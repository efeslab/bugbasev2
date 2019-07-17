FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

RUN apt-get update -qq \
 && apt-get install -yq -qq --no-install-recommends \
    python3 \
    python3-dev \
    curl \
    ca-certificates
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py
RUN pip3 install numpy scipy
RUN pip3 install --no-cache-dir tensorflow-gpu
RUN pip3 install --no-cache-dir http://download.pytorch.org/whl/cu80/torch-0.1.12.post2-cp35-cp35m-linux_x86_64.whl

COPY ./test.py /

CMD python3 test.py