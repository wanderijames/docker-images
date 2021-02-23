FROM wanderijames/hadoop:base

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.4
ENV SCALA_VERSION=2.11.12
ENV SCALA_HOME=/opt/scala
ENV SPARK_HOME /opt/spark
ENV YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_CLASSPATH=$HADOOP_HOME/share/hadoop/tools/lib/*
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
    jq

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
    && wget --no-verbose http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
    && mv spark-${SPARK_VERSION}-bin-without-hadoop ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-without-hadoop.tgz \
    && pip install -e ${SPARK_HOME}/python

