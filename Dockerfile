FROM langflowai/langflow:1.7.3

COPY flows/ /flows/

ENV LANGFLOW_LOAD_FLOWS_PATH=/flows
ENV LANGFLOW_HOST=0.0.0.0
ENV LANGFLOW_PORT=10000

EXPOSE 10000

CMD ["sh", "-c", "langflow run --host 0.0.0.0 --port ${PORT:-10000}"]
