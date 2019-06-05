# [ticket 91](https://trac.nginx.org/nginx/ticket/91)
- behavior: worker process segmentation fault
- description: there is no error_log defined at global level error from a resolver cause null pointer dereference
- sketch:
    - `ngx_resolver_create` at src/core/ngx_resolver.c:140

        `r->log = &cf->cycle->new_log;`

       Resolver is assigned a new log. (`new_log->file` has been initialized to null pointer at this time) 
    - `ngx_log_error_core` at src/core/ngx_log.c:93

        `if (log->file->fd == NGX_INVALID_FILE) {`

        `log->file = 0x0` here, therefore segmentation fault.

- patch: [Copy log_error after config parsing](https://trac.nginx.org/nginx/changeset/79142134d616a772432f78929515938ab108ae45/nginx)
