FROM ubuntu:16.04

MAINTAINER James Wanderi <wanderikinyanjui@gmail.com>

RUN apt-get update && \
        apt-get install -y software-properties-common && \
        add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update -y

RUN apt-get install -y \
	build-essential \
	python3.6 \
	python3.6-dev \
	python3-pip \
	python3.6-venv 

# update pip
RUN python3.6 -m pip install pip --upgrade && \
        python3.6 -m pip install wheel