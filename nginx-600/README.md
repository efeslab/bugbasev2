# [ticket 600](https://trac.nginx.org/nginx/ticket/600)
- behavior:
- description: Non-indexed access of prefix vars
- sketch:
  - ngx_http_get_variable at src/http/ngx_http_variables.c:565

    `if (vv && v->get_handler(r, vv, v->data) == NGX_OK) {`

    `v->get_handler` is null.

- patch: [Check if get_handler is properly set in `ngx_http_variables_init_vars()`](https://trac.nginx.org/nginx/changeset/6c99c5f00fc9f1c502ce4e7b1f9e3d26003f6c21/nginx).
