# Tensorflow bug 33894
- behavior: Segmentation Fault

- description: Eager context device issue segmentation fault after context resetting serverDef

- Affect version: tensorflow:2.0.0

- sketch:this happens because `v.variable` refers to a device which is recreated before cluster initialization. `set_server_def` essentially recreates the devices and device managers (and also destroy existing ones) so `v.device` points to invalid memory and accessing it would cause segfault.
    
