---
name: initialize-llm-wiki
description: Initialize topic or repo LLM wiki with org-safe defaults. Creates scaffold, starter pages, local guide, and optional root routing updates behind explicit consent. Includes dry-run preview, slug safety, integrity checks, run audit trail, marker versioning, and template version pinning. Use when user asks to initialize, bootstrap, or setup an LLM wiki.
---


# Initialize LLM Wiki


Scaffold LLM wiki fast. Keep writes predictable.


## Trigger


Activate on:


- `initialize llm wiki`
- `bootstrap llm wiki`
- `setup llm wiki`
- `/initialize-llm-wiki`


## Overview


LLM wiki = narrow markdown KB:


- `raw/` holds immutable source documents
- `wiki/` holds curated, interlinked pages maintained by the agent
- `AGENTS.md` tells agents how to access and manage the wiki


Default location: `<BASE_PATH>/llm-wiki-<topic>/`. Empty topic -> `<BASE_PATH>/llm-wiki/`.


## Org Baseline Mode


Run in baseline mode by default for org rollout.


Required controls:


- Opt-in root edits only
- Dry-run preview before first apply in repo
- Deterministic slug safety checks
- Post-init integrity checks
- Mixed-state rerun validation standard
- Versioned managed marker contract
- Template version pinning
- Structured run audit trail


If any required control is skipped, stop and explain remediation.


## Interview


Ask one question at a time.


Use select-style prompts for setup questions whenever possible. Include explicit default/recommended options.
For any path/topic that may be custom, include a select option for custom input (for example: "Custom path..." or "Custom topic...").


### Step 1 — Base path


Ask:


> "Choose base path for wiki roots."


Select options:


- `docs` (recommended)
- Custom path...


- Normalize path to repo-relative, no trailing slash
- If `docs` selected: `BASE_PATH = docs`
- If custom selected and provided: use custom value
- If missing directory: allow creation during apply


### Step 2 — Topic


Ask:


> "Choose wiki scope/topic."


Select options:


- Topic-scoped wiki (enter topic) (recommended)
- Repo-scoped wiki (`llm-wiki`)


- If topic-scoped selected and user provides a topic:
 - Normalize to lowercase kebab-case (strip punctuation, collapse dashes)
 - Run slug safety checks from [resources/guardrails.md](resources/guardrails.md)
 - Set `SLUG = llm-wiki-<normalized-topic>`
 - Set `WIKI_ROOT = <BASE_PATH>/<SLUG>`
 - Set `DISPLAY_TOPIC = <original topic>`
- If repo-scoped selected:
 - Set `SLUG = llm-wiki`
 - Set `WIKI_ROOT = <BASE_PATH>/llm-wiki`
 - Set `DISPLAY_TOPIC = (repo-scoped)`


### Step 3 — Root edits policy


Ask:


> "Allow root file edits in this run (`AGENTS.md`, `README.md`)?"


Select options:


- Yes (recommended)
- No


- If no: skip root file writes, still complete local scaffold
- If yes: continue with root updates


### Step 3.5 — Hot cache opt-in


Ask:


> "Enable optional hot cache for repeated interactions? (Useful for long-running or high-use scenarios; skip for one-off research.)"


Select options:


- Yes, enable hot cache (recommended)
- No, skip hot cache


- If no: `HOT_CACHE_ENABLED = false`, skip hot.md creation
- If yes: `HOT_CACHE_ENABLED = true`, create `wiki/hot.md` + add hot cache guidance to local AGENTS.md


### Step 4 — Dry-run preview


Before writes, always show preview:


- Files to create
- Managed blocks to update
- Marker version used
- Template version to stamp
- Warnings from slug/conflict checks


Ask:


> "Apply this plan?"


Select options:


- Apply
- Cancel (dry-run only)


If denied, exit with no writes. Still emit run audit entry as `dry-run`.


### Step 5 — Confirm path


Show path. Confirm before create:


> "I'll create the wiki at `<WIKI_ROOT>/`. Proceed?"


Select options:


- Proceed
- Cancel


## Scaffold


Create if missing. Never overwrite.


```
<WIKI_ROOT>/
├── raw/
├── templates/
└── wiki/
   ├── index.md
   ├── log.md
   └── hot.md       (if HOT_CACHE_ENABLED)
```


### index.md starter content


Use [templates/wiki-index.md](templates/wiki-index.md). Keep placeholders unchanged.


### log.md starter content


Use [templates/wiki-log.md](templates/wiki-log.md). Keep placeholders unchanged.


Use current date for `<TODAY>` as `YYYY-MM-DD`.


Stamp template version metadata from the template contract.


### hot.md starter content (if HOT_CACHE_ENABLED)


Use [templates/wiki-hot.md](templates/wiki-hot.md). Keep placeholders unchanged.


This file stores ~500 recent context chars to avoid re-reading wiki pages on follow-up queries.


## Local AGENTS.md


Create or update `<WIKI_ROOT>/AGENTS.md`.


On create: write template content.


On update: find managed block markers. Replace only inside markers. If missing, append block.


**Marker contract (versioned):**


```
<!-- llm-wiki-init:v1:local:start -->
<!-- llm-wiki-init:v1:local:end -->
```


Do not use old marker variants when writing new content.


**Full file content when creating:**


Use [templates/local-agents.md](templates/local-agents.md). Keep placeholders and managed markers unchanged.


If `HOT_CACHE_ENABLED = true`, insert hot cache guidance section (see [templates/hot-cache-guidance.md](templates/hot-cache-guidance.md)) into the managed block before the closing marker.


**On update (HOT_CACHE_ENABLED = true):**


If hot cache guidance is missing from the managed block, insert it. Never remove it if the user later disables hot cache (guidance stays for reference).


## Edge Cases & Idempotency


Apply idempotency + conflict rules from [resources/guardrails.md](resources/guardrails.md).


If legacy marker versions are detected, fail closed by default. Do not auto-migrate markers during a normal rerun. Show the migration preview, explain the mismatch, and require explicit user confirmation before any managed-region migration.


## Root AGENTS.md


Edit only if user opted in.


Create or update root `AGENTS.md`.


On create: write routing block as full file.


On update: find slug-specific managed block markers. Replace only block content. If missing, append block. **Never edit outside managed blocks.**


**Markers** (versioned + slug keyed):


```
<!-- llm-wiki-init:v1:root:<SLUG>:start -->
<!-- llm-wiki-init:v1:root:<SLUG>:end -->
```


**Block content (topic-scoped):**


Use [templates/root-agents-topic.md](templates/root-agents-topic.md).


**Block content (repo-scoped, no topic):**


Use [templates/root-agents-repo.md](templates/root-agents-repo.md).


### Conflict warning


Use warning text in [resources/guardrails.md](resources/guardrails.md).


## Root README.md


Edit only if user opted in.


Create or update root `README.md`.


On create: write managed section as full file.


On update: find managed block markers. Replace only block content. If missing, append block. **Never edit outside managed block.**


**Markers (versioned):**


```
<!-- llm-wiki-init:v1:readme:start -->
<!-- llm-wiki-init:v1:readme:end -->
```


### Build wiki inventory (all wikis in project)


Use discovery + row-building rules in [resources/wiki-inventory-rules.md](resources/wiki-inventory-rules.md).


### Managed README block content


Use [templates/root-readme-section.md](templates/root-readme-section.md). Keep markers + placeholders unchanged.


### README conflict warning


Use warning text in [resources/guardrails.md](resources/guardrails.md).


## Post-init integrity check


Run after apply. Fail loud if any check fails.


- Required dirs exist: `raw/`, `templates/`, `wiki/`
- Required files exist: `wiki/index.md`, `wiki/log.md`, `<WIKI_ROOT>/AGENTS.md`
- If `HOT_CACHE_ENABLED = true`: `wiki/hot.md` exists
- Managed marker pairs balanced in changed files
- If root edits enabled: README managed table includes current wiki row
- Template version stamp exists where required


Validation is not complete after clean bootstrap alone. Completion standard:


- Dry-run against a clean state
- At least one rerun in a mixed or dirty state to confirm deterministic no-op behavior, marker safety, and explicit migration handling


If failure: report exact file + fix steps.


## Run audit trail


Always emit one structured run record (even dry-run/no-op):


- `mode`: `dry-run` or `apply`
- `timestamp`
- `wiki_root`
- `topic`
- `result`: `created` | `updated` | `no-op` | `blocked`
- `files`: per-file status
- `warnings`: array


When `wiki/log.md` exists, append run record entry there. Keep append-only.


## Generated guide expectations


The local guide must encode ongoing wiki maintenance expectations, not only scaffold usage.


- Lint guidance must cover contradictions, orphan pages, missing concept pages, stale claims, and missing cross-links
- Lint guidance must recommend splitting a broad wiki into narrower topic wikis when scope expands or the wiki grows beyond roughly 100 source documents
- Scope guidance should keep wikis narrow and topic-focused rather than treating a single wiki as unbounded


## Summary output


After completing initialization, report:


```
LLM wiki initialized.


 Wiki root:   <WIKI_ROOT>/
 Base path:   <BASE_PATH>/
 Topic:       <DISPLAY_TOPIC>
 Mode:        <dry-run|apply>
 Root edits:  <enabled|disabled>
 Marker ver:  v1
 Template ver:<TEMPLATE_VERSION>
 Created:
   - <WIKI_ROOT>/raw/
   - <WIKI_ROOT>/templates/
   - <WIKI_ROOT>/wiki/
   - <WIKI_ROOT>/wiki/index.md    (if new)
   - <WIKI_ROOT>/wiki/log.md      (if new)
   - <WIKI_ROOT>/wiki/hot.md      (if new, hot cache enabled)
   - <WIKI_ROOT>/AGENTS.md        (created/updated)
   - AGENTS.md                    (created/updated, if root edits enabled)
   - README.md                    (created/updated managed wiki section, if root edits enabled)
 Integrity:
   - <pass|fail + findings>
 Warnings:
   - <none|list>


Next step: add source documents to <WIKI_ROOT>/raw/ and ask me to ingest them.
```


List only items that were actually created or changed.



