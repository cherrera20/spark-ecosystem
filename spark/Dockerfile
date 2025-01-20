# Use a lightweight JDK base image
FROM openjdk:11.0.11-jre-slim-buster as base-stage

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and build Python 3.11
ARG PYTHON_VERSION=3.11.8
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make -j $(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_VERSION}*

# Install necessary Python packages
RUN /usr/local/bin/python${PYTHON_VERSION%.*} -m pip install --upgrade pip && \
    /usr/local/bin/python${PYTHON_VERSION%.*} -m pip install virtualenv

# Set Spark and Hadoop versions as environment variables
ENV SPARK_VERSION=3.5.0 \
    HADOOP_VERSION=3 \
    SPARK_HOME=/opt/spark \
    PYTHON_VERSION=${PYTHON_VERSION%.*}

# Download and install Apache Spark
RUN wget --no-verbose -O apache-spark.tgz "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" \
    && mkdir -p /opt/spark \
    && tar -xf apache-spark.tgz -C /opt/spark --strip-components=1 \
    && rm apache-spark.tgz

# Setup the next stage for the actual Spark master and worker setup
FROM base-stage as spark-cluster-setup

# Define the working directory
WORKDIR /opt/spark

# Download additional JARs needed
RUN wget -P /opt/spark/jars https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.1/hadoop-common-3.3.1.jar \
    && wget -P /opt/spark/jars https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar \
    && wget -P /opt/spark/jars https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.2/hadoop-aws-3.2.2.jar \
    && wget -P /opt/spark/jars https://repo1.maven.org/maven2/io/delta/delta-spark_2.12/3.1.0/delta-spark_2.12-3.1.0.jar \
    && wget -P /opt/spark/jars https://repo1.maven.org/maven2/org/apache/spark/spark-hive_2.12/3.5.0/spark-hive_2.12-3.5.0.jar \
    && wget -P /opt/spark/jars https://repo1.maven.org/maven2/io/delta/delta-storage/3.1.0/delta-storage-3.1.0.jar

# Set environment variables for Spark master and worker configuration
ENV SPARK_MASTER_PORT=7077 \
    SPARK_MASTER_WEBUI_PORT=8080 \
    SPARK_LOG_DIR=/opt/spark/logs \
    SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out \
    SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out \
    SPARK_WORKER_WEBUI_PORT=8080 \
    SPARK_WORKER_PORT=7000 \
    SPARK_MASTER="spark://spark-master:7077" \
    SPARK_WORKLOAD="master" \
    PYSPARK_PYTHON=/usr/local/bin/python${PYTHON_VERSION} \
    PYSPARK_DRIVER_PYTHON=/usr/local/bin/python${PYTHON_VERSION}

# Expose the ports used by Spark master and worker
EXPOSE 8080 7077 7000

# Setup log directories and link logs to stdout for easier container log management
RUN mkdir -p $SPARK_LOG_DIR && \
    touch $SPARK_MASTER_LOG && \
    touch $SPARK_WORKER_LOG && \
    ln -sf /dev/stdout $SPARK_MASTER_LOG && \
    ln -sf /dev/stdout $SPARK_WORKER_LOG

# Crear un enlace simbólico para python3
RUN ln -sf /usr/local/bin/python3.11 /usr/local/bin/python3

# Copy the start script to the container
COPY run.sh /

# Set the command to start the Spark cluster
CMD ["/bin/bash", "/run.sh"]
