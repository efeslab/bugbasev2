#include "tensorflow/core/framework/op_kernel.h"
#include "tensorflow/core/framework/register_types.h"
#include "tensorflow/core/framework/tensor.h"
#include "tensorflow/core/framework/tensor_shape.h"
#include "tensorflow/core/framework/register_types.h"
#include "tensorflow/core/framework/op.h"
#include "tensorflow/core/framework/shape_inference.h"
#include "tensorflow/core/util/work_sharder.h"

#include <iostream>
#include <cmath>

using namespace tensorflow;

REGISTER_OP("TestBug")
    .Output("dummy: float");

class TestBugOp : public OpKernel
{
public:
explicit TestBugOp(OpKernelConstruction* context)
        : OpKernel(context)
{

}

void Compute(OpKernelContext* context) override
{
    Tensor* dummy = NULL;
    OP_REQUIRES_OK(context, context->allocate_output(0, {1},
                                                     &dummy));
    auto job = [&](int64 start, int64 limit)
    {
        for (int64 i = start; i<limit; i++)
        {
            std::cout << start << std::endl; // Segmentation fault (core dumped)
        }
    };
    
    /*
    auto job = [&](int64 start, int64 limit)
    {
        for (int i = 0; i<4; i++)
        {
            std::cout << i << std::endl; // ok
        }
    };
    */

    const DeviceBase::CpuWorkerThreads& worker_threads = *(context->device()->tensorflow_cpu_worker_threads());
    const int64_t shard_cost = 10000;
    Shard(worker_threads.num_threads, worker_threads.workers,
              (int64)100, shard_cost, job);

}
};

REGISTER_KERNEL_BUILDER(
  Name("TestBug").Device(DEVICE_CPU),
  TestBugOp
);