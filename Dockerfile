# Use a lightweight JDK base image
FROM openjdk:11.0.11-jre-slim-buster as base-stage

# Install only the necessary dependencies
RUN apt-get update && \
    apt-get install -y curl wget ca-certificates software-properties-common ssh net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Spark and Hadoop versions as environment variables
ENV SPARK_VERSION=3.5.0 \
    HADOOP_VERSION=3 \
    SPARK_HOME=/opt/spark

# Download and install Apache Spark
RUN wget --no-verbose -O apache-spark.tgz "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" \
    && mkdir -p /opt/spark \
    && tar -xf apache-spark.tgz -C /opt/spark --strip-components=1 \
    && rm apache-spark.tgz

# Setup the next stage for the actual Spark master and worker setup
FROM base-stage as spark-cluster-setup

# Define the working directory
WORKDIR /opt/spark

# Set environment variables for Spark master and worker configuration
ENV SPARK_MASTER_PORT=7077 \
    SPARK_MASTER_WEBUI_PORT=8080 \
    SPARK_LOG_DIR=/opt/spark/logs \
    SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out \
    SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out \
    SPARK_WORKER_WEBUI_PORT=8080 \
    SPARK_WORKER_PORT=7000 \
    SPARK_MASTER="spark://spark-master:7077" \
    SPARK_WORKLOAD="master"

# Expose the ports used by Spark master and worker
EXPOSE 8080 7077 7000

# Setup log directories and link logs to stdout for easier container log management
RUN mkdir -p $SPARK_LOG_DIR && \
    touch $SPARK_MASTER_LOG && \
    touch $SPARK_WORKER_LOG && \
    ln -sf /dev/stdout $SPARK_MASTER_LOG && \
    ln -sf /dev/stdout $SPARK_WORKER_LOG

# Copy the start script to the container
COPY spark/run.sh /

# Set the command to start the Spark cluster
CMD ["/bin/bash", "/run.sh"]
