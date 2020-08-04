
FROM tensorflow/tensorflow:2.3.0

RUN pip3 install --upgrade pip
RUN pip3 install scikit-learn
COPY ./test.py /
CMD python3 test.py