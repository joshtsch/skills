# Guardrails


## Org baseline mode


Default mode for rollout. Required:


- Dry-run preview before first apply in repo
- Explicit consent for root file edits
- Slug safety checks before write
- Versioned marker contract (`v1`)
- Template version pinning (`1`)
- Post-init integrity check
- Mixed-state rerun validation
- Structured run audit trail


If any required control is skipped, stop and explain remediation.


## Idempotency


| Situation                              | Action                          |
| -------------------------------------- | ------------------------------- |
| Folder already exists                  | Skip creation, continue         |
| `wiki/index.md` already exists         | Skip creation, do not overwrite |
| `wiki/log.md` already exists           | Skip creation, do not overwrite |
| Root `AGENTS.md` managed block exists  | Replace block content only      |
| Local `AGENTS.md` managed block exists | Replace block content only      |
| Root `README.md` managed block exists  | Replace block content only      |
| Markers absent in existing file        | Append new block at end         |


## Marker contract (versioned)


Use only these markers for new writes:


- Local guide: `<!-- llm-wiki-init:v1:local:start -->` / `<!-- llm-wiki-init:v1:local:end -->`
- Root agent routing: `<!-- llm-wiki-init:v1:root:<SLUG>:start -->` / `<!-- llm-wiki-init:v1:root:<SLUG>:end -->`
- Root readme section: `<!-- llm-wiki-init:v1:readme:start -->` / `<!-- llm-wiki-init:v1:readme:end -->`


When legacy markers are found, fail closed by default. Do not silently auto-upgrade or rewrite managed blocks during a normal rerun.


Allowed migration path:


- Detect legacy marker version and stop normal apply flow
- Show migration preview limited to managed regions
- Require explicit user confirmation before any migration write
- Never edit outside managed regions during migration


## Template version pinning


Stamp created/updated wiki files with:


`<!-- llm-wiki-template-version:1 -->`


On rerun, if older version detected, show migration preview and require explicit apply confirmation.


## Deterministic slug safety


Before writes:


- Normalize topic to candidate slug
- Fail if slug collides with existing wiki using different display topic unless user confirms reuse
- Fail if slug hits reserved names or existing non-wiki directories
- Suggest disambiguated alternatives (for example suffixes)


## Conflict scans


After root `AGENTS.md` update, scan for `docs/llm-wiki` refs outside managed markers. If found, warn:


> "I found references to an llm-wiki path outside my managed block in `AGENTS.md`. I didn't touch them — you may want to review for conflicts."


After root `README.md` update, scan for `docs/llm-wiki` refs outside managed markers. If found, warn:


> "I found references to an llm-wiki path outside my managed block in `README.md`. I didn't touch them — you may want to review for conflicts."


## Post-init integrity checks


After apply:


- Required directories exist (`raw/`, `templates/`, `wiki/`)
- Required files exist (`wiki/index.md`, `wiki/log.md`, local `AGENTS.md`)
- Managed marker start/end pairs are balanced in all touched files
- If root writes enabled, root readme contains row for current wiki
- Template version stamp exists in starter pages


Validation standard before calling rollout hardening complete:


- Dry-run clean bootstrap path
- Rerun in mixed or dirty state to verify deterministic no-op behavior and fail-closed migration handling


If any check fails, return `fail` with file-level findings and remediation hints.


## Run audit trail


Always emit one structured record for every invocation, including dry-run and no-op:


- mode
- timestamp
- wiki_root
- topic
- result
- files[] statuses
- warnings[]



