# Initialize LLM Wiki


Init topic or repo wiki with org-safe defaults.
 
## File Structure


```
initialize-llm-wiki/
├── resources/
│   ├── guardrails.md
│   └── wiki-inventory-rules.md
├── SKILL.md
├── templates/
│   ├── local-agents.md
│   ├── root-agents-repo.md
│   ├── root-agents-topic.md
│   ├── root-readme-section.md
│   ├── wiki-index.md
│   └── wiki-log.md
└── README.md
```


## What It Does


Creates and maintains a narrow LLM wiki scaffold. Writes are predictable, idempotent, and auditable.


### Key Features


- **Configurable base path** — default `docs`, supports custom paths
- **Dry-run first** — preview writes before apply
- **Opt-in root edits** — `AGENTS.md` and `README.md` only with consent
- **Slug safety** — collision and reserved-name checks
- **Versioned markers** — stable managed-block contract (`v1`)
- **Template pinning** — scaffold stamped with template version (`1`)
- **Integrity checks** — verify required files and marker balance post-apply
- **Run audit trail** — structured record for `dry-run`, `apply`, and `no-op`
- **Idempotent writes** — skip existing scaffold files, replace managed blocks only


## How to Trigger


Use any of:


- `/initialize-llm-wiki`
- "initialize llm wiki"
- "bootstrap llm wiki"
- "setup llm wiki"


## Example Workflow


1. User invokes the skill with `initialize llm wiki`
2. Agent asks base path and topic, then computes slug/path
3. Agent shows dry-run plan and asks for apply consent
4. Agent writes scaffold + optional root managed blocks
5. Agent runs integrity checks and emits run audit record


## Page Format


Every wiki page follows a standard structure:


```markdown
# Page Title


**Summary**: One to two sentences describing this page.


**Sources**: List of raw source files this page draws from.


**Last updated**: YYYY-MM-DD


---


Main content with [[wiki-links]] to related concepts.


## Related pages


- [[related-concept]]
```


All factual claims must cite their source: `(source: filename)`.


## Managed Blocks


The skill uses comment markers to update `AGENTS.md` files safely, allowing multiple wikis to coexist without file conflicts:


```
<!-- llm-wiki-init:v1:local:start -->
...
<!-- llm-wiki-init:v1:local:end -->
```


Other managed markers:


- Root routing: `llm-wiki-init:v1:root:<SLUG>:{start|end}`
- Root readme: `llm-wiki-init:v1:readme:{start|end}`


Only managed regions are touched.



