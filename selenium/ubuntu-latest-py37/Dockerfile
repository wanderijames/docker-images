FROM ubuntu:latest

MAINTAINER James Wanderi <wanderikinyanjui@gmail.com>

ENV TZ="Europe/London"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get --no-install-recommends -y install \
      software-properties-common \
      python3.7 \
      python3.7-dev \
      python3.7-tk \
      python3.7-distutils \
    && rm -rf /tmp/* \
    && ln -sf /usr/bin/python3.7 /usr/bin/python \
    && ln -sf /usr/bin/python3.7 /usr/bin/python3

RUN apt-get --no-install-recommends -y install python3-pip

RUN pip install -U pip \
    && pip install \
        black==22.3.0 \
        isort \
        behave==1.2.6 \
        behavex==1.6.0 \
        boto3==1.26.37 \
        botocore==1.29.37 \
        seleniumbase==4.12.3