#issue 22770
FROM tensorflow/tensorflow:1.11.0-py3

COPY ./test.py /notebooks

RUN pip install better_exchook==1.20171121.105512

CMD python3 test.py