# issue 29820

FROM tensorflow/tensorflow:1.13.1-py3

# prepare source code that generate the seg fault
COPY ./testbug.cc /usr/local/lib/python3.5/dist-packages/tensorflow/include
COPY ./testbug.py /usr/local/lib/python3.5/dist-packages/tensorflow/include
COPY ./CMakeLists.txt /usr/local/lib/python3.5/dist-packages/tensorflow/include

WORKDIR /usr/local/lib/python3.5/dist-packages/tensorflow/include

# install required cmake and compile
RUN apt-get update && apt-get install -y cmake
RUN mkdir build 
WORKDIR /usr/local/lib/python3.5/dist-packages/tensorflow/include/build
RUN cmake .. && make

WORKDIR /usr/local/lib/python3.5/dist-packages/tensorflow/include

CMD python3 testbug.py