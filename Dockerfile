FROM langflowai/langflow:1.7.3

COPY flows/ /flows/

ENV LANGFLOW_LOAD_FLOWS_PATH=/flows

EXPOSE 7860
