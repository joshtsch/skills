# skills
Public repo for sharing helpful agent skills

<!-- llm-wiki-init:v1:readme:start -->

## LLM Wikis

This repo uses topic-scoped LLM wikis for focused research and documentation.

| Wiki                 | Topic     | Location                   | Guide                               | Last Updated |
| -------------------- | --------- | -------------------------- | ----------------------------------- | ------------ |
| `llm-wiki-llm-wikis` | LLM Wikis | `docs/llm-wiki-llm-wikis/` | `docs/llm-wiki-llm-wikis/AGENTS.md` | 2026-05-09   |

<!-- llm-wiki-init:v1:readme:end -->

### How to use

Use the wiki workflow for source ingestion and knowledge synthesis:

- Add or import raw sources into `docs/llm-wiki-llm-wikis/raw/`
- Let the agent build and update pages in `docs/llm-wiki-llm-wikis/wiki/`
- Use `docs/llm-wiki-llm-wikis/AGENTS.md` for page conventions and workflows
- Keep the wiki narrow and topic-specific; split into new wikis once coverage grows too broad

Useful agent prompts:

- `Ingest docs/llm-wiki-llm-wikis/raw/<filename> into the wiki`
- `Answer this question using docs/llm-wiki-llm-wikis/wiki and cite pages`
- `Lint docs/llm-wiki-llm-wikis/wiki for contradictions, orphans, and stale claims`

### Recommended structure

- `docs/<topic>-wiki/raw/` — immutable imported sources
- `docs/<topic>-wiki/wiki/` — generated wiki content
- `docs/<topic>-wiki/templates/` — reusable page templates
- `docs/<topic>-wiki/AGENTS.md` — agent guide and workflow schema

## Syncing locked sources

Use `knowledge_sync.py` to materialize sources from `KNOWLEDGE.lock`:

```bash
python3 scripts/knowledge_sync.py --lockfile KNOWLEDGE.lock
```

If a package entry has a directory destination, the `fileName` field determines the output filename.

## Common DVC and Make commands

This repo uses DVC for imported source tracking. Common commands:

- `make dvc-pull` — pull data from the DVC remote
- `make dvc-push` — push cached data to the remote
- `make dvc-status` — check DVC file status
- `make dvc-list` — list DVC-tracked files
- `make dvc-add PATH=<path>` — add a local file or directory to DVC
- `make dvc-import-url URL=<url> DEST=<dest>` — import a remote URL into a DVC-tracked destination
- `make dvc-commit` — commit DVC changes
- `make sync-knowledge` — sync lockfile sources via `scripts/knowledge_sync.py`

Run `make help` for the full command list.

## DVC + MinIO

This repo includes a local MinIO setup for DVC remote storage.

1. Copy the environment example:

```bash
cp .env.example .env
```

2. Start MinIO and create the bucket:

```bash
docker compose up -d
```

3. Verify DVC remote config:

```bash
cat .dvc/config
cat .dvc/config.local
```

Default values:

- API: `http://localhost:9000`
- Console: `http://localhost:9001`
- Bucket: `knowledge-sync`

The compose setup provisions the bucket, and `.dvc/config` points to the local S3-compatible endpoint.

### Typical workflow

1. Import a source from a URL into `docs/llm-wiki-llm-wikis/raw/`
2. Push the cached object to MinIO
3. Commit the `.dvc` file and the imported file path
4. Update tracked sources explicitly when upstream content changes

### Importing a remote source

Use the Make wrapper to import a remote URL into a destination path:

```bash
make dvc-import-url URL=https://example.com/article.md DEST=docs/llm-wiki-llm-wikis/raw/article.md
```

That creates the imported file and a corresponding `.dvc` tracking file.

### Restoring materialized files

To restore imported files from the local cache or remote:

```bash
dvc pull
dvc checkout
```

Use this after cloning the repo or after removing local imported files.

### Updating a tracked source

To refresh a tracked import and push the update:

```bash
dvc update docs/llm-wiki-llm-wikis/raw/<file>.md.dvc
dvc push
```

### Commit the result

After importing or updating a source, commit the changed files:

```bash
git add docs/llm-wiki-llm-wikis/raw/<file>.md docs/llm-wiki-llm-wikis/raw/<file>.md.dvc
git commit -m "Track new source with DVC"
```

### Example source

The repo also contains an older example import at `docs2/llm-wiki.md` tracked by `docs2/llm-wiki.md.dvc`.


