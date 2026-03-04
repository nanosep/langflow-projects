FROM langflowai/langflow:1.7.3

COPY flows/ /flows/

ENV LANGFLOW_LOAD_FLOWS_PATH=/flows
ENV LANGFLOW_HOST=0.0.0.0
ENV LANGFLOW_PORT=7860

EXPOSE 7860

CMD ["sh", "-c", "langflow run --host 0.0.0.0 --port ${PORT:-7860}"]
