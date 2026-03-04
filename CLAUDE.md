# langflow-projects

Nano's Langflow flows — versioned and deployed to Railway.

## Active Projects
- **Po vs No Po** — AP invoice classifier. Deployed at: https://langflow-projects-production.up.railway.app

## Stack
- Langflow 1.7.3 (pinned)
- Railway (Docker web service, port 10000) — $5/mes Hobby plan
- GitHub MCP for repo management

## Deployment
1. Push changes to main branch on GitHub
2. Railway auto-rebuilds from Dockerfile
3. Env vars live in Railway dashboard — never in code

## Required env vars (set in Railway dashboard, not here)
- LANGFLOW_AUTO_LOGIN=true
- OPENAI_API_KEY=sk-...
- PORT=10000

## Dockerfile key settings
- FROM langflowai/langflow:1.7.3 (pinned — do not change without testing)
- LANGFLOW_HOST=0.0.0.0
- LANGFLOW_PORT=10000
- CMD: sh -c "langflow run --host 0.0.0.0 --port ${PORT:-10000}"

## Platforms tried and discarded
- Render free/starter: FAILED — 512MB RAM, OOM
- Oracle Cloud Always Free ARM: FAILED — Madrid saturado (problema crónico global)
- HuggingFace Spaces: descartado — sleep + flows efímeros

## Pending (próxima sesión)
- [ ] Configurar APIs que faltan en los componentes del flow PO vs No-PO
- [ ] Verificar LANGFLOW_LOAD_FLOWS_PATH funciona en 1.7.3 (flow auto-cargado o manual)
