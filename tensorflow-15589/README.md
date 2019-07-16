# Tensorflow bug15589
- Behaviour: Segmentation fault / Core Dumped
- Description: Segmentation Fault (core dumped) on get_session_handle 
- Affect version: 1.4.0
- Failure Sketch:
	* In /usr/local/lib/python2.7/dist-packages/tensorflow/python/client/session.py, line 1302, in `_run_fn (session=<SwigPyObject at remote 0x7fff6e664330>, feed_dict={}, fetch_list=['GetSessionHandle:0'], target_list=[], options=None, run_metadata=None, status=<SwigPyObject at remote 0x7fff6e670f00>)`
	* `GetSessionHandleOp::Compute()` get a pointer out of the context, and `SessionState::GetNewId()` is called passing the pointer, and then the pointer is passed to ` nsync_mu_lock()` and from there, the pointer got invalid.
- Fixed version: tensroflow:latest 