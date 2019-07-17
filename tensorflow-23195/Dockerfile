# issue 23195

FROM tensorflow/tensorflow:1.11.0

RUN apt-get update
RUN apt-get install -y wget 
RUN wget https://gist.githubusercontent.com/brianmartin/4f221eb838dce8099342f829fb13253d/raw/00c2a1736b9a292f8a6fb88164d240a766468744/gistfile1.txt

CMD python gistfile1.txt