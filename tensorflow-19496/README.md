# Tensorflow bug 19496
- behavior: Segmentation fault
- Affect version: tensorflowv1.8.0-py3
- Description: Rpc ops (rpc, try_rpc) cause seg fault
- sketch:
    - At tensorflow/core/util/rpc/call_container.h line 105,  token_(ctx->cancellation_manager()->get_cancellation_token()), where `token_(ctx->cancellation_manager()` is a invalid pointer in this case. To fix this, making RPC op handle the case where cancellation manager is not initi.
    - Fix like this `token_(ctx->cancellation_manager() != nullptr ? ctx->cancellation_manager()->get_cancellation_token() : CancellationManager::kInvalidToken),`
- Fix: Commit 2c75dbfd2d37a3c06d34cc4b12682a63a75503f7
