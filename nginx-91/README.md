# [ticket 91](https://trac.nginx.org/nginx/ticket/91)
- behavior: worker process segmentation fault
- description: there is no error_log defined at global level error from a resolver cause null pointer dereference
- sketch:

- patch: [Copy log_error after config parsing](https://trac.nginx.org/nginx/changeset/79142134d616a772432f78929515938ab108ae45/nginx)
