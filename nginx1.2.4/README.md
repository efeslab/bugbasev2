# [ticket 235](https://trac.nginx.org/nginx/ticket/235)
- behavior: worker process segmentation fault
- description: Shared ssl_session_cache is used in a default server while 'ssl_session_cache none` is specified in some SNI-based virtual host.
- sketch:
  - src/event/ngx_event_openssl.c:1676 OpenSSL doesn't offer an api to access the session index, `shm_zone` ends up being a null pointer
  - src/event/ngx_event_openssl.c:1678 access member of struct referenced by a null pointer
- patch: [SSL: preserve default server context in connection](https://trac.nginx.org/nginx/changeset/97f102a13f3373ed27d1d0d8f78ac9af8d88a0ff/nginx)
