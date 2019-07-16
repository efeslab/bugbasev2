# issue 10648
FROM tensorflow/tensorflow:1.0.0

RUN mkdir tests

COPY ./example_test.py /notebooks/tests


CMD python -m unittest discover -s tests -p "example_test.py"