aws sqs --endpoint-url http://localhost:4566 list-queues --region us-east-1  | jq '.QueueUrls'
