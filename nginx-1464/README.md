# [ticket 1464](https://trac.nginx.org/nginx/ticket/1464)
- behavior: worker process segmentation fault
- description: Non-default virtual server missing certificate
- sketch:
  - ngx_http_process_request at src/http/ngx_http_request.c:1895

    `sscf = ngx_http_get_module_srv_conf(r, ngx_http_ssl_module);`
    
    in which `#define ngx_http_get_module_srv_conf(r, module)  (r)->srv_conf[module.ctx_index]`
    
    `sscf` is loaded according to the request. Since the requested server has no certificate, the ssl context under `sscf` is missing. (WATCH OUT: The root cause dates back to how the server config is processed)

  - ngx_http_process_request at src/http/ngx_http_request.c:1921

    `ngx_ssl_remove_cached_session(sscf->ssl.ctx,`

    in which `sscf->ssl.ctx` is a null pointer since the requested virtual server has no ssl context. Removing cached session based on a missing ssl context results in segmentation fault.
    
- patch: [SSL: using default server context in session remove](https://trac.nginx.org/nginx/changeset/9d14931cec8c21d248860dacd5ba0bbf325a00a9/nginx)
