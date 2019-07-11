# Tensorflow bug 26879
- behavior: Segmentation fault
- Affect version: tensorflow2.0.0-alpha0
- description: tf.stack cause a segmentation fault time, this can lead to a crash. (A nullptr dereference)
- sketch:
    - In ```tensorflow/tensorflow/python/eager/pywrap_tfe_src.cc``` line 1841, the function ```PySequence_Fast_GET_ITEM``` is trying to access the object not through `PySequence_Fast`. And the object pointer in this a null pointer.
    - In order to fix this ```tensorflow::Safe_PyObjectPtr fast_item(PySequence_Fast(item, "Could not parse sequence."));``` and a check ``` if (fast_item.get() == nullptr) { return false; }``` is needed.
- Fix: commit 04b97cde86550995da57d16d81084006456ccce5 [https://github.com/tensorflow/tensorflow/pull/27133/commits/04b97cde86550995da57d16d81084006456ccce5]
