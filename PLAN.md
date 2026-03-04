# Council Plan — 2026-03-04 — langflow-deploy

**Goal**: Deploy Po vs No Po Langflow flow (live + runnable) via Render, GitHub repo as source
**Output**: GitHub repo `langflow-projects` + live Render URL shareable with anyone
**Done when**: Render URL opens Langflow 1.7.3 UI with povsnonpo_1.7.3_final.json loaded and runnable

---

## Council
| Specialist | Role |
|-----------|------|
| Organizer | Phase 0 — scaffold project folder, .gitignore, README |
| Ops Specialist | Dockerfile, Render config, env var list |
| Architect | Docker image strategy, flow import method |

---

## Repo Structure
```
langflow-projects/
├── flows/
│   └── povsnonpo_1.7.3_final.json
├── viz/
│   └── langflow-viz-povsnonpo-final-beauty-20260302-1721.html
├── Dockerfile
├── .gitignore
└── README.md
```

---

## Phases

| # | Phase | Owner | Deliverable | Success Criterion | Terminal |
|---|-------|-------|-------------|-------------------|----------|
| 0 | Scaffold project folder | Organizer | `Desktop/langflow-projects/` with CLAUDE.md + memory/ | Dir exists, files present | T1 (RULES) |
| 1 | Write Dockerfile | Ops | `Dockerfile` — FROM langflowai/langflow:1.7.3, COPY flows/, ENV LOAD_PATH | File written, FROM tag pinned | T2 |
| 2 | Write .gitignore + README | Organizer | `.gitignore` (no .env, no __pycache__) + minimal README | Files exist, .env excluded | T2 |
| 3 | Create GitHub repo via MCP | Ops | `langflow-projects` repo on GitHub | Repo visible at github.com/[user]/langflow-projects | T2 |
| 4 | Push all files via MCP | Ops | All files on main branch | GitHub shows correct file tree | T2 |
| 5 | HUMAN — Create Render Web Service | Nano | Render service pointing to GitHub repo (Docker) | Nano confirms service created | manual |
| 6 | HUMAN — Set env vars in Render | Nano | OPENAI_API_KEY + LANGFLOW_AUTO_LOGIN=true in Render dashboard | Nano confirms vars saved | manual |
| 7 | Verify deploy | Ops | Render URL loads Langflow UI | HTTP 200, Langflow UI visible | T2 |
| 8 | Verify flow loaded | Nano or auto | povsnonpo_1.7.3_final.json visible in Langflow | Flow appears in Langflow UI | manual |

---

## Dockerfile Strategy

```dockerfile
FROM langflowai/langflow:1.7.3
COPY flows/ /flows/
ENV LANGFLOW_LOAD_FLOWS_PATH=/flows
```

- If `LANGFLOW_LOAD_FLOWS_PATH` doesn't work in 1.7.3: fallback = Nano uploads flow via Langflow UI (30s manual step)
- Port: 7860 (Langflow default) — must be set in Render service config

## Render Config (manual — Phase 5+6)
- Service type: Web Service
- Build: Docker (auto-detected from Dockerfile in repo root)
- Port: 7860
- Env vars to set in Render dashboard (NOT in code):
  - `LANGFLOW_AUTO_LOGIN=true`
  - `OPENAI_API_KEY=sk-...`

---

## Wrap Checkpoints
| After Phase | What to save to MEMORY.md |
|-------------|--------------------------|
| 4 | GitHub repo URL |
| 7 | Render URL |
| 8 | Whether LANGFLOW_LOAD_FLOWS_PATH works in 1.7.3 (confirmed or fallback used) |

---

## Cost Model
No API calls in build pipeline. Render free tier: 512MB RAM, sleeps after 15min.
Flow execution cost = OpenAI API at runtime, same as local. No new infra cost.

---

## Failure Paths
| Phase | Failure Mode | Degraded Output | Action |
|-------|-------------|-----------------|--------|
| 1 | LANGFLOW_LOAD_FLOWS_PATH not supported in 1.7.3 | Flow not auto-loaded | Nano imports via Langflow UI — 30s fallback |
| 5 | Render build fails | No deploy | Ask Nano to paste Render build log |
| 5 | Free tier OOM (512MB too low for Langflow) | Crash on startup | Upgrade to Render Starter ($7/mo) or test with langflow-backend only |
| 7 | URL loads but flow won't run | UI visible, execution fails | Check missing env var (likely OPENAI_API_KEY) |

---

## Nice-to-Have (not in this plan)
- HTML viz tab in deployed UI — deferred to future session
