#!/bin/bash

# Load Spark environment configurations
source "/opt/spark/bin/load-spark-env.sh"

# Function to start the Spark Master
start_master() {
    export SPARK_MASTER_HOST=$(hostname)
    cd /opt/spark/bin
    ./spark-class org.apache.spark.deploy.master.Master \
        --ip $SPARK_MASTER_HOST \
        --port $SPARK_MASTER_PORT \
        --webui-port $SPARK_MASTER_WEBUI_PORT \
        >> $SPARK_MASTER_LOG
}

# Function to start the Spark Worker
start_worker() {
    cd /opt/spark/bin
    ./spark-class org.apache.spark.deploy.worker.Worker \
        --webui-port $SPARK_WORKER_WEBUI_PORT \
        $SPARK_MASTER \
        >> $SPARK_WORKER_LOG
}

# Evaluate workload type and act accordingly
case "$SPARK_WORKLOAD" in
    master)
        echo "Starting Spark Master..."
        start_master
        ;;
    worker)
        echo "Starting Spark Worker..."
        start_worker
        ;;
    submit)
        echo "Executing Spark Submit"
        # Add specific commands for submit task if necessary
        ;;
    *)
        echo "Undefined workload type: $SPARK_WORKLOAD. Must specify: master, worker, submit"
        ;;
esac
