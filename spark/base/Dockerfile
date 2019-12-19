FROM alpine:3.9

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.4
ENV HADOOP_VERSION=2.7.7
ENV SPARK_HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.11.12
ENV SCALA_HOME=/opt/scala
ENV SPARK_HOME /opt/spark
ENV PYSPARK_PYTHON /usr/bin/python
ENV LIVY_VERSION=0.6.0

RUN apk add \
    curl \
    build-base \
    ca-certificates \
    gcc \
    gfortran \
    bash \
    python3 \
    python3-dev \
    jq \
    wget \
    openjdk8-jre

# Ensure we have Python 3 and Pip
RUN echo "*** Installing python and pip ****" \
    && rm -f /usr/bin/python \
    && rm -f /usr/bin/pip \
    && ln -sf python3 /usr/bin/python \
    && echo "**** Install pip ****" \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools wheel


# Install Scala
RUN echo "*** Installing Scala ***" \
    && wget --no-verbose "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" \
    && tar xzf "scala-${SCALA_VERSION}.tgz" \
    && mkdir "${SCALA_HOME}" \
    && rm "scala-${SCALA_VERSION}/bin/"*.bat \
    && mv "scala-${SCALA_VERSION}/bin" "scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" \
    && rm -r "scala-${SCALA_VERSION}" \
    && rm -f "scala-${SCALA_VERSION}.tgz" \
    && ln -s "${SCALA_HOME}/bin/"* "/usr/bin/"

# Install Spark and adding pyspark by pip instead of env (ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH)
RUN echo "*** Installing Spark ***" \
    && wget --no-verbose http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION} ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz \
    && pip install -e ${SPARK_HOME}/python


# Install Livy
RUN echo "*** Installing Livy ***" \
    && wget https://www-eu.apache.org/dist/incubator/livy/${LIVY_VERSION}-incubating/apache-livy-${LIVY_VERSION}-incubating-bin.zip \
    && unzip apache-livy-${LIVY_VERSION}-incubating-bin.zip \
    && rm apache-livy-${LIVY_VERSION}-incubating-bin.zip \
    && mv apache-livy-${LIVY_VERSION}-incubating-bin /opt/livy \
    && chmod a+x /opt/livy/bin/livy-server
RUN mkdir /opt/livy/logs


# Install Pyspark ML dependencies
RUN echo "*** Install Pyspark ML dependencies ***" \
    && pip install Cython \
    && pip install numpy \
    && pip install pandas

# Install postgresql deps and drivers
RUN echo "*** Installing Postgres psycopg2 and drivers ***" \
    && apk add \
        libpq \
        postgresql-dev \
    && wget https://jdbc.postgresql.org/download/postgresql-42.2.7.jar \
    && mv postgresql-42.2.7.jar ${SPARK_HOME}/jars/postgresql-42.2.7.jar \
    && pip install psycopg2-binary


# Install redshift deps and drivers
RUN echo "*** Installing redshift drivers ***" \
    && wget https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/1.2.36.1060/RedshiftJDBC42-no-awssdk-1.2.36.1060.jar \
    && mv RedshiftJDBC42-no-awssdk-1.2.36.1060.jar ${SPARK_HOME}/jars/RedshiftJDBC42-no-awssdk-1.2.36.1060.jar

# Install Python dev tools
RUN echo "*** Installing Python dev stuff ***" \
    && apk add linux-headers zeromq-dev \
    && pip install \
        tox \
        jupyter 
