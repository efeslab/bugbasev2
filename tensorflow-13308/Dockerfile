# issue 13308

FROM tensorflow/tensorflow:1.3.0

# prepare source code that generate the seg fault

COPY ./Makefile /usr/local/lib/python2.7/dist-packages/tensorflow/include
COPY ./test_op.py /usr/local/lib/python2.7/dist-packages/tensorflow/include
COPY ./tf_op.cpp /usr/local/lib/python2.7/dist-packages/tensorflow/include

WORKDIR /usr/local/lib/python2.7/dist-packages/tensorflow/include

RUN make

CMD python test_op.py