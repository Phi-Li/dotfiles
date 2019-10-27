<p align="center">
    <img src="openlogo-75.png" alt="Debian Logo">
</p>

# Apache2 Debian Default Page

You should __replace this file__ (located at `/var/www/html/index.html`) before continuing to operate your HTTP server.

## Configuration Overview

Debian's Apache2 default configuration is different from the upstream default configuration, and split into several files optimized for interaction with Debian tools.

The configuration system is __fully documented in `/usr/share/doc/apache2/README.Debian.gz`__. Refer to this for the full documentation. Documentation for the web server itself can be found by accessing the __manual__ if the `apache2-doc` package was installed on this server.

The configuration layout for an Apache2 web server installation on Debian systems is as follows:

    /etc/apache2/
    |-- apache2.conf
    |       `--  ports.conf
    |-- mods-enabled
    |       |-- *.load
    |       `-- *.conf
    |-- conf-enabled
    |       `-- *.conf
    |-- sites-enabled
    |       `-- *.conf


- `apache2.conf` is the main configuration file. It puts the pieces together by including all remaining configuration files when starting up the web server.

- `ports.conf` is always included from the main configuration file. It is used to determine the listening ports for incoming connections, and this file can be customized anytime.

- Configuration files in the `mods-enabled/`, `conf-enabled/` and `sites-enabled/` directories contain particular configuration snippets which manage modules, global configuration fragments, or virtual host configurations, respectively.

- They are activated by symlinking available configuration files from their respective `*-available/` counterparts. These should be managed by using our helpers `a2enmod`, `a2dismod`, `a2ensite`, `a2dissite`, and `a2enconf`, `a2disconf` . See their respective man pages for detailed information.

- The binary is called `apache2`. Due to the use of environment variables, in the default configuration, `apache2` needs to be started/stopped with `/etc/init.d/apache2` or `apache2ctl`. __Calling `/usr/bin/apache2` directly will not work__ with the default configuration.

## Document Roots

By default, Debian does not allow access through the web browser to _any_ file apart of those located in `/var/www`, [__`public_html`__](https://httpd.apache.org/docs/2.4/mod/mod_userdir.html) directories (when enabled) and `/usr/share` (for web applications). If your site is using a web document root located elsewhere (such as in `/srv`) you may need to whitelist your document root directory in `/etc/apache2/apache2.conf`.

The default Debian document root is `/var/www/html`. You can make your own virtual hosts under `/var/www`. This is different to previous releases which provides better security out of the box.

## `<VirtualHost>` Directive

|  |  |
| --- | --- |
| Description | Contains directives that apply only to a specific hostname or IP address |
| Syntax | `<VirtualHost addr[:port] [addr[:port]] ...> ... </VirtualHost> ` |
| Context | server config |
| Status | Core |
| Module | `core` |

_`Addr`_ can be any of the following, optionally followed by a colon and a port number (or *):

- The IP address of the virtual host;
- A fully qualified domain name for the IP address of the virtual host (not recommended);
- The character `*`, which acts as a wildcard and matches any IP address.
- The string `_default_`, which is an alias for `*`

IPv6 addresses must be specified in square brackets because the optional port number could not be determined otherwise.

Each Virtual Host must correspond to a different _IP address_, different _port number_, or a different _host name_ for the server, in the former case (different IP address) the server machine must be configured to accept IP packets for multiple addresses. (If the machine does not have multiple network interfaces, then this can be accomplished with the `ifconfig alias` command -- if your OS supports it).

__Note__: The use of `<VirtualHost>` does __not__ affect what addresses Apache httpd listens on. You may need to ensure that Apache httpd is listening on the correct addresses using `Listen`.

A `ServerName` should be specified inside each `<VirtualHost>` block. If it is absent, the `ServerName` from the "main" server configuration will be inherited.

When a request is received, the server first maps it to the best matching `<VirtualHost>` based on the local _IP address_ and _port_ combination only. __Non-wildcards__ have a higher precedence. If no match based on IP and port occurs at all, __the "main" server configuration__ is used.

If multiple virtual hosts contain the best matching IP address and port, the server selects from these virtual hosts the best match based on the requested _hostname_. If no matching name-based virtual host is found, then the first listed virtual host that matched the _IP address_ will be used. As a consequence, the first listed virtual host for a given _IP address_ and _port_ combination is the default virtual host for that IP and port combination.

__Security__: See the [security tips](https://httpd.apache.org/docs/current/misc/security_tips.html) document for details on why your security could be compromised if the directory where log files are stored is writable by anyone other than the user that starts the server.
