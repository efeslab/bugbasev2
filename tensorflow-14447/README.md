# Tensorflow bug14623
- Behaviour: Deadlock
- Description: PrefetchDataset with buffer_size==0 results in deadlock
- Affect version: 1.4.0
- Failure sketch:
    * ```buffer_size``` at tensorflow/tensorflow/core/kernels/prefetch_dataset_op.cc line 36-40 ``` int64 buffer_size; 
 OP_REQUIRES_OK( 
     ctx, ParseScalarArgument<int64>(ctx, "buffer_size", &buffer_size)); 
 *output = new Dataset(input, buffer_size); ```      
    * The c++ side's assertion does not cover all the cases, which will cause problem if the buffersize is a ```tf.Tensor```. The original assertion (from python) was ```assert buffer_size > 0, "The buffer_size ({}) has to be > 0.".format(buffer_size)```
    * In order to fix, add assertion check on tensorflow/tensorflow/core/kernels/prefetch_dataset_op.cc line 36-40, ```OP_REQUIRES(ctx, buffer_size > 0, errors::InvalidArgument("buffer_size must be > 0"));```
- Fixed version: Stated Above