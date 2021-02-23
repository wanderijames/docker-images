FROM alpine:3.9

ENV DAEMON_RUN=true
ARG HADOOP_VERSION=2.7.7
ENV HADOOP_FILE=hadoop-$HADOOP_VERSION
ENV HADOOP_HOME=/opt/$HADOOP_FILE
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin


RUN apk add \
	bash \
    wget \
    openjdk8-jre


# Install Hadoop
RUN echo "*** Installing Had ***" \
    && wget --no-verbose "https://archive.apache.org/dist/hadoop/common/${HADOOP_FILE}/${HADOOP_FILE}.tar.gz" \
    && tar xvzf "${HADOOP_FILE}.tar.gz" \
    && mv ${HADOOP_FILE} ${HADOOP_HOME} \
    && rm ${HADOOP_FILE}.tar.gz