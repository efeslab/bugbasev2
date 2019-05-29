# [ticket 54](https://trac.nginx.org/nginx/ticket/54)
- command:
    ```
    docker image build -t nginx .
    docker run -it --add-host website.com.ua:0.0.0.0 nginx
    ```
- behavior: worker process segmentation fault
- description: Non-default servers may not have ssl context created if there are no certificate defined.
- sketch:    
    - ngx_http_ssl_servername at src/http/ngx_http_variables.c:672

        `sscf = ngx_http_get_module_srv_conf(r, ngx_http_ssl_module);`

        in which `#define ngx_http_get_module_srv_conf(r, module) (r)->srv_conf[module.ctx_index]`

        `sscf` is loaded according to the request. Since the requested server has no certificate, the ssl context under `sscf` is missing. (WATCH OUT: The root cause dates back to how the server config is processed)

    - ngx_http_ssl_servername at src/http/ngx_http_variables.c:681

        `SSL_set_verify(ssl_conn, SSL_CTX_get_verify_mode(sscf->ssl.ctx), SSL_CTX_get_verify_callback(sscf->ssl.ctx));`

        in which `sscf->ssl.ctx = 0x0`. And trying to obtain SSL information with a null pointer results in segmentation fault.

- patch: [Fixed segfault on ssl servers without cert with SNI](https://trac.nginx.org/nginx/attachment/ticket/54/patch-nginx-ssl.txt)
