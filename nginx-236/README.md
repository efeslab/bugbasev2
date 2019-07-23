# [ticket 236](https://trac.nginx.org/nginx/ticket/236)
- behavior: worker process segmentation fault
- description: Nginx crashes when started with stapling enabled.
- sketch:
    - `ngx_http_ssl_create_srv_conf` at src/http/modules/ngx_http_ssl_module.c:351

        `sscf = ngx_pcalloc(cf->pool, sizeof(ngx_http_ssl_srv_conf_t));`

        The memory of ssl service config `sscf` is allocated and initialized here. At the same time, `sscf->ssl->ctx` is initialized to null pointer, the value of which is never changed afterwards until nginx crashes.

    - `ngx_ssl_stapling_resolver` at src/event/ngx_event_openssl_stapling.c:439

        `staple = SSL_CTX_get_ex_data(ssl->ctx, ngx_ssl_stapling_index);`

        in which nginx tried to obtain ssl staling information based on the context of ssl and the index of ssl stapling but segmentation fault because `ssl->ctx = 0x0`.

- patch: N/A

## Reproduce by building dependencies from source
#### Details
* I installed `make apt-src wget` from `apt-get` and try to use `apt-src install <package>` to install dependencies from source. More details about `apt-src` is at https://wiki.debian.org/apt-src.
* Need to add `deb-src http://ftp.debian.org/debian stretch main` to `\etc\apt\sources.list` and copy file 02dpkg-buildpackage to `/etc/apt/apt.conf.d/02dpkg-buildpackage` which configures the build argument. Detail about the exact command can be checked at linux manual page. [http://man7.org/linux/man-pages/man1/dpkg-buildpackage.1.html]
* Run `apt-src update` before installing any dependency.
* Use `apt-src --build install <package>` to build dependency from source.
* When configuring the nginx before make, add flag `--with-cc-opt="-static -static-libgcc" --with-ld-opt="-static"`.
