# langflow-projects

Nano's Langflow flows — versioned and deployed to Render.

## Live Deploy

> URL added after Phase 7

## Flows

| Flow | Version | Description |
|------|---------|-------------|
| `povsnonpo_1.7.3_final.json` | 1.7.3 | AP invoice classifier — PO vs No-PO |

## Stack

- Langflow 1.7.3 (pinned)
- Render (Docker web service, port 7860)

## Run locally

```bash
docker build -t langflow-projects .
docker run -p 7860:7860 \
  -e LANGFLOW_AUTO_LOGIN=true \
  -e OPENAI_API_KEY=sk-... \
  langflow-projects
```

Then open: http://localhost:7860

## Env vars (set in Render dashboard — never in code)

| Var | Value |
|-----|-------|
| `LANGFLOW_AUTO_LOGIN` | `true` |
| `OPENAI_API_KEY` | `sk-...` |
