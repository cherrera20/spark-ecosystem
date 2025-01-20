### Spark Ecosystem 🚀🔥

Welcome to **Spark Ecosystem**, a fully operational local setup to experiment with a Spark-based ecosystem. This project leverages `docker-compose` to create a cluster with Spark, Kafka, LocalStack, RabbitMQ, PostgreSQL, Hive, Airflow, and other supporting tools—all running locally! 🐳✨

---

## Features ✨

- **Apache Spark**: A Spark master and two workers to execute distributed computations.
- **Kafka**: Message streaming with Kafka, including topic initialization.
- **Hive Metastore**: Centralized metadata storage for Spark SQL.
- **LocalStack**: Mock AWS services for development and testing (e.g., S3).
- **RabbitMQ**: Message broker for your pub/sub or task queue needs.
- **PostgreSQL**: RDBMS support for applications like Hive and Airflow.
- **Airflow**: Workflow orchestration made easy.
- **Superset**: Data visualization and dashboarding tool.
- **Jupyter**: Interactive notebooks for data exploration with PySpark.
- **Prometheus & Grafana**: Monitoring and visualization of your cluster.

---

## Getting Started 🛠️

### Prerequisites 📝

Ensure you have the following installed:

- Docker 🐋
- Docker Compose 📦

### Setup & Run ▶️

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/spark-ecosystem.git
   cd spark-ecosystem
   ```

2. Build and start the services:
   ```bash
   docker-compose up --build
   ```

3. Access the services using their respective ports:

   | Service           | URL/Port               |
      |-------------------|------------------------|
   | Spark Master      | [http://localhost:9090](http://localhost:9090) |
   | Spark Worker A    | [http://localhost:9091](http://localhost:9091) |
   | Spark Worker B    | [http://localhost:9093](http://localhost:9093) |
   | Kafka             | `localhost:9092`       |
   | Hive Metastore    | `localhost:9083`       |
   | Airflow           | [http://localhost:8080](http://localhost:8080) |
   | Superset          | [http://localhost:8081](http://localhost:8081) |
   | Grafana           | [http://localhost:3000](http://localhost:3000) |
   | Prometheus        | [http://localhost:19090](http://localhost:19090) |
   | Jupyter Notebook  | [http://localhost:8888](http://localhost:8888) |

---

## Directory Structure 🗂️

```plaintext
.
├── docker-compose.yml        # Compose file defining the ecosystem
├── spark/                    # Spark configurations and Dockerfiles
├── data/                     # Data storage for Hive and Spark
├── notebooks/                # Jupyter notebooks for PySpark experiments
├── prometheus/               # Prometheus configuration
├── superset/                 # Superset setup
├── airflow-data/             # Airflow DAGs, logs, and config
├── hive/                     # Hive-specific configurations
```

---

## Customization ⚙️

- Update `spark-defaults.conf` to configure Spark settings.
- Use `metrics.properties` for monitoring with Prometheus.
- Modify Kafka topics in the `init-kafka` service if needed.

---

## Contributing 🤝

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

## License 📜

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

Happy Spark-ing! 🌟