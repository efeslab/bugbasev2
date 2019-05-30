# [ticket 791](https://trac.nginx.org/nginx/ticket/791)
- behavior: worker process segmentation fault
- description: If sub_filter directive was only specified at http{} level, sub filter internal data remained uninitialized. That would lead to a crash in runtime.
- sketch:    

- patch: [Sub filter: fixed initialization in http{} level](https://trac.nginx.org/nginx/attachment/ticket/791/sub-main-conf.patch)
