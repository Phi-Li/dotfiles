### 8.1 Proxies

The standard way to specify proxy location, which Wget recognizes, is using the following environment variables:

- `http_proxy` & `https_proxy`: If set, the `http_proxy` and `https_proxy` variables should contain the URLs of the proxies for HTTP and HTTPS connections respectively.

- `ftp_proxy`: This variable should contain the URL of the proxy for FTP connections.

    It is quite common that `http_proxy` and `ftp_proxy` are set to the same URL.

- `no_proxy`: This variable should contain a comma-separated list of domain extensions proxy should _not_ be used for. For instance, if the value of `no_proxy` is ‘`.mit.edu`’, proxy will not be used to retrieve documents from MIT.

In addition to the environment variables, proxy location and settings may be specified from within Wget itself.

- ‘`--no-proxy`’
- ‘`proxy = on/off`’: This option and the corresponding command may be used to suppress the use of proxy, even if the appropriate environment variables are set.

<br>

- ‘`http_proxy =` _URL_’
- ‘`https_proxy =` _URL_’
- ‘`ftp_proxy =` _URL_’
- ‘`no_proxy =` _string_’

These startup file variables allow you to override the proxy settings specified by the environment.
