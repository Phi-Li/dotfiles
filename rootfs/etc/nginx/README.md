# Welcome to nginx!

If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to [nginx.org](https://nginx.org/).

Commercial support is available at [nginx.com](https://nginx.com/).

_Thank you for using nginx._

### `ngx_http_core_module`

|     |     |
| --- | --- |
| Syntax: | `location [ = | ~ | ~* | ^~ ] uri { ... }`<br>`location @name { ... }` |
| Default: | — |
| Context: | `server`, `location` |

Sets configuration depending on a _request URI_.

The matching is performed against a normalized URI, after:
- Decoding the text encoded in the “`%XX`” form;
- Desolving references to relative path components “`.`” and “`..`”;
- Possible [compression](http://nginx.org/en/docs/http/ngx_http_core_module.html#merge_slashes) of two or more adjacent slashes into a single slash.

A location can either be defined by a _prefix string_, or by a _regular expression_.

Regular expressions are specified with the preceding “`~*`” modifier (for case-insensitive matching), or the “`~`” modifier (for case-sensitive matching).

1. To find location matching a given request, nginx first checks locations defined using the prefix strings (__prefix locations__). Among them, the location with the __longest__ matching prefix is selected and remembered.

2. Then regular expressions are checked, in the order of their appearance in the configuration file. The search of regular expressions terminates on the __first__ match, and the corresponding configuration is used. If no match with a regular expression is found then the configuration of the prefix location remembered earlier is used. 

`location` blocks can be nested, with some exceptions mentioned below.

If the longest matching prefix location has the “`^~`” modifier then regular expressions are not checked. 

Also, using the “`=`” modifier it is possible to define an exact match of URI and location. If an exact match is found, the search terminates. For example, if a “`/`” request happens frequently, defining “`location = /`” will speed up the processing of these requests, as search terminates right after the first comparison. Such a location cannot obviously contain nested locations.

    location = / {              “/”     “/index.html”   “/documents/document.html”  “/documents/1.jpg”  “/images/1.gif”
        [ configuration A ]
    }

    location / {                        “/index.html”   “/documents/document.html”  “/documents/1.jpg”  “/images/1.gif”
        [ configuration B ]
    }

    location /documents/ {                              “/documents/document.html”  “/documents/1.jpg”  “/images/1.gif”
        [ configuration C ]
    }

    location ^~ /images/ {                                                          “/documents/1.jpg”  “/images/1.gif”
        [ configuration D ]
    }

    location ~* \.(gif|jpg|jpeg)$ {                                                 “/documents/1.jpg”
        [ configuration E ]
    }

For case-insensitive operating systems such as macOS and Cygwin, matching with prefix strings ignores a case (0.7.7). However, comparison is limited to one-byte locales.

Regular expressions can contain captures (0.7.40) that can later be used in other directives.

If a location is defined by a prefix string that ends with the slash character, and requests are processed by one of [`proxy_pass`](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass), [`fastcgi_pass`](http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_pass), [`uwsgi_pass`](http://nginx.org/en/docs/http/ngx_http_uwsgi_module.html#uwsgi_pass), [`scgi_pass`](http://nginx.org/en/docs/http/ngx_http_scgi_module.html#scgi_pass), [`memcached_pass`](http://nginx.org/en/docs/http/ngx_http_memcached_module.html#memcached_pass), or [`grpc_pass`](http://nginx.org/en/docs/http/ngx_http_grpc_module.html#grpc_pass), then the special processing is performed.

In response to a request with URI equal to this string, but without the trailing slash, a __permanent redirect__ with the code __301__ will be returned to the requested URI __with the slash appended__. If this is not desired, an exact match of the URI and location could be defined like this:

    location /user/ {
        proxy_pass http://user.example.com;
    }

    location = /user {
        proxy_pass http://login.example.com;
    }

The “`@`” prefix defines a __named location__. Such a location is not used for a regular request processing, but instead used for request redirection. They cannot be nested, and cannot contain nested locations.
