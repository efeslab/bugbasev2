# Tensorflow bug 29695
- behavior: Race condition / Deadlock (The program hangs and cannot be ended even with ctrl + c)
- Affect version: tensorflowv1.12.0
- sketch:
    - Stack trace: In ```call_function (oparg=<optimized out>, pp_stack=0x7fffffffd260)``` at ../Python/ceval.c:4350 seems to invoke a race condition
    - Output from gdb info threads: 
        * ` Thread 0x7ffff7faf840 (LWP 27148) "python" syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38`
        * ```Thread 0x7fffa2256700 (LWP 27153) "python" pthread_cond_wait@@GLIBC_2.3.2 () at ../sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185```
        * ```Thread 0x7fffa1a55700 (LWP 27154) "python" pthread_cond_wait@@GLIBC_2.3.2 () at ../sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185```
    - This indicates that the threads are waiting for some shared resources, the session close() tries to release the shared resources by calling``` ResourceMgr::Clear()```, during which, as the generator dataset did not finish the iteration yet, it needs to delete the python generator by calling the finalizing function at [https://github.com/tensorflow/tensorflow/blob/2a705b9d1524a856cd4c36a53629f25de97aba65/tensorflow/core/kernels/data/generator_dataset_op.cc#L95]. However, when running the finalizing function, the ```done function```[https://github.com/tensorflow/tensorflow/blob/2a705b9d1524a856cd4c36a53629f25de97aba65/tensorflow/core/kernels/data/captured_function.cc#L632] triggers the ```ResourceMgr::CleanUp()```[https://github.com/tensorflow/tensorflow/blob/2a705b9d1524a856cd4c36a53629f25de97aba65/tensorflow/core/framework/resource_mgr.cc#L218-L243] which causes the **deadlock** with ```ResourceMgr::Clear()```. 
- Fix: Fixed here [https://github.com/tensorflow/tensorflow/commit/5448f25041ed5d32b8aee08250e8ec66e7353593]
