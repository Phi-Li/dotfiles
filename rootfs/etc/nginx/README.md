# Welcome to nginx!

If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to [nginx.org](https://nginx.org/).

Commercial support is available at [nginx.com](https://nginx.com/).

_Thank you for using nginx._

## [Nginx Web Server / Directory Structure](https://wiki.debian.org/Nginx/DirectoryStructure)

    /etc/nginx/
    |-- nginx.conf
    |       `--  mime.types
    |-- modules-enabled
    |       `-- *.conf
    |-- conf.d
    |       `-- *.conf
    |-- sites-available
    |       `-- *
    |-- sites-enabled
    |       `-- *
    |-- snippets
    |       `-- *.conf
    |-- apps.d
    |       `-- *.conf
    |-- proxy_params
    |-- fastcgi.conf
    |-- fastcgi_params
    |-- scgi_params
    |-- uwsgi_params
    |-- koi-utf
    |-- koi-win
    |-- win-utf

## [`ngx_http_core_module`](http://nginx.org/en/docs/http/ngx_http_core_module.html)

__`location`__

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

```nginx
location = / {            # “/”     “/index.html”   “/documents/document.html”  “/documents/1.jpg”  “/images/1.gif”
    [ configuration A ]
}

location / {                      # “/index.html”   “/documents/document.html”  “/documents/1.jpg”  “/images/1.gif”
    [ configuration B ]
}

location /documents/ {                            # “/documents/document.html”  “/documents/1.jpg”  “/images/1.gif”
    [ configuration C ]
}

location ^~ /images/ {                                                        # “/documents/1.jpg”  “/images/1.gif”
    [ configuration D ]
}

location ~* \.(gif|jpg|jpeg)$ {                                               # “/documents/1.jpg”
    [ configuration E ]
}
```

For case-insensitive operating systems such as macOS and Cygwin, matching with prefix strings ignores a case (0.7.7). However, comparison is limited to one-byte locales.

Regular expressions can contain captures (0.7.40) that can later be used in other directives.

If a location is defined by a prefix string that ends with the slash character, and requests are processed by one of [`proxy_pass`](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass), [`fastcgi_pass`](http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_pass), [`uwsgi_pass`](http://nginx.org/en/docs/http/ngx_http_uwsgi_module.html#uwsgi_pass), [`scgi_pass`](http://nginx.org/en/docs/http/ngx_http_scgi_module.html#scgi_pass), [`memcached_pass`](http://nginx.org/en/docs/http/ngx_http_memcached_module.html#memcached_pass), or [`grpc_pass`](http://nginx.org/en/docs/http/ngx_http_grpc_module.html#grpc_pass), then the special processing is performed.

In response to a request with URI equal to this string, but without the trailing slash, a __permanent redirect__ with the code __301__ will be returned to the requested URI __with the slash appended__. If this is not desired, an exact match of the URI and location could be defined like this:

```nginx
location /user/ {
    proxy_pass http://user.example.com;
}

location = /user {
    proxy_pass http://login.example.com;
}
```

The “`@`” prefix defines a __named location__. Such a location is not used for a regular request processing, but instead used for request redirection. They cannot be nested, and cannot contain nested locations.

#### Embedded Variables

- `$host` in this order of precedence:
    - host name from the request line,
    - host name from the “Host” request header field,
    - the server name matching a request

- `$scheme`: request scheme, “`http`” or “`https`”

- `$server_port`: port of the server which accepted a request

## [`ngx_http_proxy_module`](http://nginx.org/en/docs/http/ngx_http_proxy_module.html)

- IP bind: `proxy_bind`
- Buffer: `proxy_buffer_size`, `proxy_buffering`, `proxy_buffers`, `proxy_busy_buffers_size`, `proxy_request_buffering`
- Cache: `proxy_cache`, `proxy_cache_background_update`, `proxy_cache_bypass`, `proxy_cache_convert_head`, `proxy_cache_key`, `proxy_cache_lock`, `proxy_cache_lock_age`, `proxy_cache_lock_timeout`, `proxy_cache_max_range_offset`, `proxy_cache_methods`, `proxy_cache_min_uses`, `proxy_cache_path`, `proxy_cache_purge`, `proxy_cache_revalidate`, `proxy_cache_use_stale`, `proxy_cache_valid`, `proxy_no_cache`
- Connection timeout: `proxy_connect_timeout`
- Cookie: `proxy_cookie_domain`, `proxy_cookie_path`
- Byte-range support: `proxy_force_ranges`
- Header: `proxy_headers_hash_bucket_size`, `proxy_headers_hash_max_size`, `proxy_hide_header`, `proxy_ignore_headers`
- HTTP version: `proxy_http_version`
- Client abort: `proxy_ignore_client_abort`
- Error intercepting: `proxy_intercept_errors`
- Rate limit: `proxy_limit_rate`
- Temporary file: `proxy_max_temp_file_size`, `proxy_temp_file_write_size`, `proxy_temp_path`
- HTTP method: `proxy_method`
- Next server: `proxy_next_upstream`, `proxy_next_upstream_timeout`, `proxy_next_upstream_tries`
- Proxy pass: `proxy_pass`, `proxy_pass_header`, `proxy_pass_request_body`, `proxy_pass_request_headers`
- Read timeout: `proxy_read_timeout`
- Redirection: `proxy_redirect`
- Send timeout: `proxy_send_timeout`
- Set body: `proxy_set_body`
- Set header: `proxy_set_header`
- TCP keepalive: `proxy_socket_keepalive`
- SSL: `proxy_ssl_certificate`, `proxy_ssl_certificate_key`, `proxy_ssl_ciphers`, `proxy_ssl_crl`, `proxy_ssl_name`, `proxy_ssl_password_file`, `proxy_ssl_protocols`, `proxy_ssl_server_name`, `proxy_ssl_session_reuse`, `proxy_ssl_trusted_certificate`, `proxy_ssl_verify`, `proxy_ssl_verify_depth`
- Disk storage: `proxy_store`, `proxy_store_access`

```nginx
location / {
    proxy_pass       http://localhost:8000;
    proxy_set_header Host      $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```

__`proxy_pass`__

|     |     |
| --- | --- |
| Syntax: | `proxy_pass URL;` |
| Default: | — |
| Context: | `location`, `if in location`, `limit_except` |

Sets the _protocol_ and _address_ of a proxied server and an optional _URI_ to which a _location_ should be mapped. As a protocol, “`http`” or “`https`” can be specified. The address can be specified as a _domain name_ or _IP address_, and an optional _port_:

```nginx
proxy_pass http://localhost:8000/uri/;
```

or as a _UNIX-domain socket path_ specified after the word “`unix`” and enclosed in colons:

```nginx
proxy_pass http://unix:/tmp/backend.socket:/uri/;
```

If a domain name resolves to several addresses, all of them will be used in a __round-robin__ fashion. In addition, an address can be specified as a [server group](http://nginx.org/en/docs/http/ngx_http_upstream_module.html).

Parameter value can contain variables. In this case, if an address is specified as a _domain name_, the name is searched among the described server groups, and, if not found, is determined using a [resolver](http://nginx.org/en/docs/http/ngx_http_core_module.html#resolver).

A request URI is passed to the server as follows:

- If the `proxy_pass` directive is specified with a _URI_, then when a request is passed to the server, the part of a [normalized](http://nginx.org/en/docs/http/ngx_http_core_module.html#location) request URI matching the location is replaced by a URI specified in the directive:

    ```ngnix
    location /name/ {
        proxy_pass http://127.0.0.1/remote/;
    }

    /name/ => http://127.0.0.1/remote/
    ```

- If `proxy_pass` is specified without a URI, the request URI is passed to the server in the __same__ form as sent by a client when the original request is processed, or the __full__ normalized request URI is passed when processing the changed URI:

    ```nginx
    location /some/path/ {
        proxy_pass http://127.0.0.1;
    }

    /some/path/ => http://127.0.0.1/some/path/
    ```

In some cases, the part of a request URI to be replaced __cannot__ be determined:

- When location is specified using a _regular expression_, and also inside _named locations_.

    In these cases, `proxy_pass` should be specified __without__ a _URI_.

- When the URI is changed inside a _proxied location_ using the [`rewrite`](http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#rewrite) directive, and this __same__ configuration will be used to process a request (`break`):

    ```nginx
    location /name/ {
        rewrite    /name/([^/]+) /users?name=$1 break;
        proxy_pass http://127.0.0.1;
    }

    /name/([^/]+) => http://127.0.0.1/users?name=$1
    ```

    In this case, the URI specified in the directive is __ignored__ and the __full__ changed request URI is passed to the server.

- When variables are used in `proxy_pass`:

    ```nginx
    location /name/ {
        proxy_pass http://127.0.0.1$request_uri;
    }

    /name/ => http://127.0.0.1$request_uri
    ```

    In this case, if URI is specified in the directive, it is passed to the server __as is__, replacing the original request URI.

[WebSocket](http://nginx.org/en/docs/http/websocket.html) proxying requires special configuration and is supported since version 1.3.13.

__`proxy_redirect`__

|     |     |
| --- | --- |
| Syntax: |	`proxy_redirect default;`<br>`proxy_redirect off;`<br>`proxy_redirect` _redirect_ _replacement_; |
| Default: |	`proxy_redirect default;` |
| Context: |	`http`, `server`, `location` |

Sets the text that should be changed in the “`Location`” and “`Refresh`” header fields of a proxied server response.

```nginx
proxy_redirect http://localhost:8000/two/ http://frontend/one/;
```

`Location: http://localhost:8000/two/some/uri/` => `Location: http://frontend/one/some/uri/`

A server name may be omitted in the _`replacement`_ string:

```nginx
proxy_redirect http://localhost:8000/two/ /;
```

then the primary server’s name and port, if different from 80, will be inserted.

Add host names to relative redirects issued by a proxied server:

```nginx
proxy_redirect / /;
```

A _`replacement`_ string can contain variables:

```nginx
proxy_redirect http://localhost:8000/ http://$host:$server_port/;
```

A _`redirect`_ can also contain (1.1.11) variables:

```nginx
    proxy_redirect http://$proxy_host:8000/ /;
```

The directive can be specified (1.1.11) using regular expressions.

_`redirect`_

- Start with “`~`” (case-sensitive)
- Start with “`~*`” (case-insensitive)

_`replacement`_ can reference named and positional captures.

```nginx
proxy_redirect ~^(http://[^:]+):\d+(/.+)$ $1$2;
proxy_redirect ~*/user/([^/]+)/(.+)$      http://$1.example.com/$2;
```

The default replacement specified by the `default` parameter uses the parameters of the `location` and `proxy_pass` directives:

```nginx
location /one/ {
    proxy_pass     http://upstream:port/two/;
    proxy_redirect default;
```

are equivalent to

```nginx
location /one/ {
    proxy_pass     http://upstream:port/two/;
    proxy_redirect http://upstream:port/two/ /one/;
```

The default parameter is not permitted if proxy_pass is specified using variables.

There could be several `proxy_redirect` directives:

```nginx
proxy_redirect default;
proxy_redirect http://localhost:8000/  /;
proxy_redirect http://www.example.com/ /;
```

The `off` parameter cancels the effect of all `proxy_redirect` directives on the current level:

```nginx
proxy_redirect off;
proxy_redirect default;
proxy_redirect http://localhost:8000/  /;
proxy_redirect http://www.example.com/ /;
```
