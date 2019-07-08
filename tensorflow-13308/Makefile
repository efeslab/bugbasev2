TF_INC=$(shell python -c 'import tensorflow as tf; print tf.sysconfig.get_include()')

tfop.so: tf_op.cpp
	g++ tf_op.cpp -std=c++11 --shared -fPIC -o tfop.so -I $(TF_INC) -D_GLIBCXX_USE_CXX11_ABI=0
