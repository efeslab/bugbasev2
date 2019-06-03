# [ticket 1782](https://trac.nginx.org/nginx/ticket/1782)
- behavior: worker process segmentation fault
- description: set `error_page` for proxy server and make a conditional client request for a cached response
- sketch:
    - `ngx_http_internal_redirect` at src/http/ngx_http_core_module.c:2436

        `r->cache = NULL;`

    - `ngx_http_upstream_cache_background_update` at src/http/ngx_http_upstream.c:1100

        `if (!r->cached || !r->cache->background) {`

    `r->cached` is not necessarily reset to `0` though `r->cache` becomes `NULL`

- patch: unresovled
