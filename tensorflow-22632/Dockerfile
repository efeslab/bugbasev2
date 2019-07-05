# issue 22632
FROM tensorflow/tensorflow:1.10.0-py3

COPY test.py /notebooks

RUN mkdir -p /tmp/dataset/flowers_jpegs/train/{rose,daisy}

RUN pip install keras

CMD python3 test.py