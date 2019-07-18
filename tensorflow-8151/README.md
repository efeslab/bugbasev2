# Tensorflow bug8158
- Behaviour: Segmentation fault / Core Dumped
- Description: Calling Generic conv with data_format='NCHW' Leads to Segfault
- Affect version: 1.0.1
- Failure Sketch:
    * At tensorflow/core/kernels/conv_ops.cc:65] Check failed: data_format == FORMAT_NHWC. Generic conv implementation only supports NHWC tensor format for now. 
- Fixed version: tensroflow:latest