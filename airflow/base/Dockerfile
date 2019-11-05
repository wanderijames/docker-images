FROM python:3.6-slim

ARG AIRFLOW_HOME=/root/airflow
ARG AIRFLOW_VERSION=1.10.3
ENV SLUGIFY_USES_TEXT_UNIDECODE=yes
ENV AIRFLOW_HOME=${AIRFLOW_HOME}
ENV AIRFLOW__CORE__EXECUTOR=SequentialExecutor
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False

# install deps
RUN apt-get update -y \
    && apt-get install -y \
        wget \
        libczmq-dev \
        curl \
        libssl-dev \
        git \
        inetutils-telnet \
        bind9utils \
        zip \
        unzip \
        gcc \
        logrotate \
    && apt-get clean

RUN useradd -ms /bin/bash airflow

# Since we install vanilla Airflow, we also want to have support for Postgres and Kubernetes
RUN pip install -U setuptools \
    && pip install cryptography \
        psycopg2-binary==2.7.4 \
        awscli \
        celery \
        flask-bcrypt \
        apache-airflow[crypto]==${AIRFLOW_VERSION}

RUN pip install -U Flask==1.0.4

COPY bootstrap.sh /bootstrap.sh
COPY logrotate /etc/logrotate.d/airflow
RUN chmod a+x /bootstrap.sh
WORKDIR /usr/local/lib/python3.6/site-packages/airflow