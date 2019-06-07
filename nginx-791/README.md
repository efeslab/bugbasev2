# [ticket 791](https://trac.nginx.org/nginx/ticket/791)
- behavior: worker process segmentation fault
- description: If sub_filter directive was only specified at http{} level, sub filter internal data remained uninitialized. That would lead to a crash in runtime.
- sketch:    
    - `ngx_http_core_server` at src/http/ngx_http_core_module.c

        2987: `mconf = module->create_loc_conf(cf);

        `mconf` is of type `ngx_http_sub_loc_conf_t *`. The value pointed by `mconf` is initialize here. (*i.e.* `mconf->tables` is initialized to null pointer here. Besides, the value of `mconf->tables` remains null pointer until it is dereferenced and crash happens.

        2992: `ctx->loc_conf[ngx_modules[i]->ctx_index] = mconf;`

        `mconf` is stored in the configuration array of current context for later use.

    - `ngx_http_sub_header_filter` at src/http/modules/ngx_http_sub_filter_module.c

        178: `slcf = ngx_http_get_module_loc_conf(r, ngx_http_sub_filter_module);`

        in which `#define ngx_http_get_module_loc_conf(r, module) (r)->loc_conf[module.ctx_index]`.

        193: `ctx->tables = slcf->tables;`

        251: `ctx->saved.data = ngx_pnalloc(r->pool, ctx->tables->max_match_len - 1);`

        `ctx->tables = 0x0` results in segmentation fault.

- patch: [Sub filter: fixed initialization in http{} level](https://trac.nginx.org/nginx/attachment/ticket/791/sub-main-conf.patch)
