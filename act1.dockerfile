FROM ubuntu:20.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
ENV FLASK_APP=model_api.py
ENV FLASK_ENV = development
ENV FLASK_DEBUG = 0

#Install pip
RUN apt-get update \ 
    && apt -y upgrade
RUN apt-get install python3-pip -y \
    && apt-get install git -y
    #install virtualenv
RUN pip3 install virtualenv
#create venv named analisis
RUN mkdir analisis
RUN cd analisis
RUN virtualenv analisis
#activate venv analisis
RUN . analisis/bin/activate
RUN apt-get update
RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda -V
RUN deactivate

RUN cd .. \ 
    && mkdir api \
    && cd api
RUN virtualenv api
RUN . api/bin/activate
RUN pip3 install Flask
RUN pip3 install flask-swagger-ui

#clone git repo

RUN git clone https://github.com/amilcaralex97/api-flask-modelo-predictivo.git \
    && cd api-flask-modelo-predictivo \
    && git checkout act-4-post-put

WORKDIR /api-flask-modelo-predictivo

RUN pip install -r requirements.txt

RUN export FLASK_APP=model_api.py
RUN export FLASK_ENV=development
RUN export FLASK_DEBUG=0

#Run server on container
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]