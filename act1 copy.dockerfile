FROM ubuntu:20.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

#Install pip
RUN apt-get update \ 
    && apt -y upgrade
RUN apt-get install python3-pip -y
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
RUN pip3 install Flask \
    && pip install swagger

# pull clone git repo