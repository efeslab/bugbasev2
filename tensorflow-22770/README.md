# Tensorflow bug 22770
- behavior: Segmentation fault
- Affect version: tensorflowv1.11.0, better_exchook 1.20171121.105512[https://pypi.org/project/better_exchook/1.20171121.105512/#files]
- description: When ```__repr__``` is called on some TF objects at the wrong time, this can lead to a crash.
- sketch:
    - In ```tensorflow/python/framework/ops.py``` line 1897 in name ```return c_api.TF_OperationName(self._c_op)``` is trying to access the object.
    - However, by ```tensorflow/tensorflow/python/framework/c_api_util.py``` line 52, ``` c_api.TF_DeleteGraph(self.graph) ``` has already delete the graph, which leads to segmentation fault.
- Fix: Use a new version of better_exchook [https://pypi.org/project/better_exchook/1.20190330.152253/]
