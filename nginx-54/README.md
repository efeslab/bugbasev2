# [ticket 54](https://trac.nginx.org/nginx/ticket/54)
- behavior: worker process segmentation fault
- description: Non-default servers may not have ssl context created if there are no certificate defined.
- sketch:
    
- patch: [Fixed segfault on ssl servers without cert with SNI](https://trac.nginx.org/nginx/attachment/ticket/54/patch-nginx-ssl.txt)
