# Tensorflow bug29820
- Behaviour: Segmentation fault
- Description: Attempting to use the CPU Work Sharder segfaults on g++ 5.4.0
- Affect version: 1.13.1
- Failure sketch:
	* Haven't got a stack trace yet and it seems that the problem doesn't have a very detailed explanation right now, will try to add failure sketch later.
- Fixed version: Change g++ to 4.8 will fix the problem, related to https://github.com/tensorflow/tensorflow/issues/13308