<p align="center">
  <a href="https://codely.com">
    <img src="https://user-images.githubusercontent.com/10558907/170513882-a09eee57-7765-4ca4-b2dd-3c2e061fdad0.png" width="300px" height="92px" alt="Codely logo"/>
  </a>
</p>

<h1 align="center">
    🎇 Spark ecosystem docker example
</h1>

<p align="center">
    <a href="https://github.com/CodelyTV"><img src="https://img.shields.io/badge/Codely-OS-green.svg?style=flat-square" alt="Codely Open Source projects"/></a>
    <a href="https://pro.codely.com"><img src="https://img.shields.io/badge/Codely-Pro-black.svg?style=flat-square" alt="Codely Pro courses"/></a>
</p>

<p align="center">
    Custom Spark-Kafka Cluster
</p>

<p align="center">
  This project sets up a custom Spark-Kafka cluster using Docker and Docker Compose. It includes Apache Spark, Apache Kafka, PostgreSQL, Hive Metastore, LocalStack for S3, Prometheus, and Grafana.
</p>



## Project Structure

- **hive/conf/.hiverc**: Hive initialization script to add necessary JAR files.
- **hive/conf/hive-site.xml**: Configuration file for Hive Metastore.
- **hive/conf/jars/**: Directory containing necessary JAR files for Hive.
- **prometheus/prometheus.yml**: Configuration file for Prometheus.
- **spark/metrics.properties**: Configuration file for Spark metrics.
- **spark/run.sh**: Script to start Spark Master, Worker, or Submit jobs.
- **docker-compose.yml**: Docker Compose configuration file to set up the entire cluster.
- **Dockerfile**: Dockerfile to build the Spark cluster image.

## Setup Instructions

### Prerequisites

- Docker
- Docker Compose

### Building the Docker Image

First, build the Docker image for the Spark cluster:

```bash
docker build -t my-spark-cluster:3.5.0 .
```

### Running the Cluster

Start the cluster using Docker Compose:

```bash
docker-compose up
```

This command will start all the services defined in the `docker-compose.yml` file.

### Accessing Services

- **Spark Master**: [http://localhost:9090](http://localhost:9090)
- **Spark Worker A**: [http://localhost:9091](http://localhost:9091)
- **Spark Worker B**: [http://localhost:9093](http://localhost:9093)
- **Kafka**: Accessible on port 9092
- **S3 (LocalStack)**: Accessible on port 4566
- **PostgreSQL**: Accessible on port 5432
- **Hive Metastore**: Accessible on port 9083
- **Spark Thrift Server**: Accessible on port 10000
- **Grafana**: [http://localhost:3000](http://localhost:3000)
- **Prometheus**: [http://localhost:19090](http://localhost:19090)

## Monitoring and Metrics

### Prometheus

Prometheus is configured to scrape metrics from the Spark Master, Workers, and Executors.

### Grafana

Grafana is set up to visualize the metrics collected by Prometheus. Access it at [http://localhost:3000](http://localhost:3000).

## Additional Notes

- Ensure that the specified volumes and paths exist and are accessible by Docker.
- Customize the provided configurations as needed for your specific use case.
