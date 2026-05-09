# skills
Public repo for sharing helpful agent skills

<!-- llm-wiki-init:v1:readme:start -->


## LLM Wikis


This project uses topic-scoped LLM wikis for focused research and documentation.


| Wiki                 | Topic     | Location                   | Guide                               | Last Updated |
| -------------------- | --------- | -------------------------- | ----------------------------------- | ------------ |
| `llm-wiki-llm-wikis` | Llm Wikis | `docs/llm-wiki-llm-wikis/` | `docs/llm-wiki-llm-wikis/AGENTS.md` | 2026-05-04   |


### How to Use


Use these prompts with the agent:


- **Ingest source:** `Ingest docs/llm-wiki-llm-wikis/raw/<filename> into the wiki`
- **Ask from wiki:** `Answer this question using docs/llm-wiki-llm-wikis/wiki and cite pages`
- **Lint wiki:** `Lint docs/llm-wiki-llm-wikis/wiki for contradictions, orphans, and stale claims`


For detailed contribution workflow, page format, and rules, open each wiki's local guide in the **Guide** column.


### Recommendations


We recommend installing Obsidian and adding each wiki as a separate vault to navigate wiki documents and backlinks effectively.


Keep wikis narrow and well-targeted. Research and field experience suggest LLM wikis are most effective around ~100 source documents per wiki. Split broad topics into additional wikis and lint them often.

## Syncing locked sources

Use `knowledge_sync.py` to pull each source from `KNOWLEDGE.lock` into its configured local destination.

Example:

```bash
python3 knowledge_sync.py --lockfile KNOWLEDGE.lock
```

If a package entry contains a directory destination, the `fileName` field is used to write the fetched source file.

## DVC + MinIO

This repo includes a local MinIO server for trying DVC-backed remote storage.

1. Copy the example environment file:

```bash
cp .env.example .env
```

2. Start MinIO and create the DVC bucket:

```bash
docker compose up -d
```

3. Verify the DVC remote config:

```bash
cat .dvc/config
cat .dvc/config.local
```

The default setup uses:

- API: `http://localhost:9000`
- Console: `http://localhost:9001`
- Bucket: `knowledge-sync`

`docker-compose.yml` provisions the bucket automatically, and `.dvc/config` points DVC at the local S3-compatible endpoint.

### Next step after MinIO is running

Once `docker compose up -d` is running successfully, the normal DVC workflow is:

1. Import a document from a source URL into a local destination.
2. Push the cached object to MinIO.
3. Commit the `.dvc` file and the imported document path to git.
4. Later, update the imported source explicitly when you want newer upstream content.

### Add a document from a source

This repo already contains an example import at `docs2/llm-wiki.md` tracked by `docs2/llm-wiki.md.dvc`.

To add another source, choose a destination path and run:

```bash
dvc import-url \
  https://gist.githubusercontent.com/karpathy/442a6bf555914893e9891c11519de94f/raw \
  docs/llm-wiki-llm-wikis/raw/llm-wiki.md
```

That creates:

- the materialized file at `docs/llm-wiki-llm-wikis/raw/llm-wiki.md`
- a DVC tracking file next to it, typically `docs/llm-wiki-llm-wikis/raw/llm-wiki.md.dvc`

Push the imported content to the MinIO remote:

```bash
dvc push
```

### Sync materialized files from DVC

To restore imported files from the local DVC cache or the MinIO remote:

```bash
dvc pull
dvc checkout
```

Use this after cloning the repo on another machine or after deleting local imported files.

### Update a tracked source

When you want to check the upstream source for changes and advance the tracked import:

```bash
dvc update docs/llm-wiki-llm-wikis/raw/llm-wiki.md.dvc
dvc push
```

This fetches the current upstream content, updates the `.dvc` file metadata, rewrites the materialized file, and uploads the new cached object to MinIO.

### Commit the result

After adding or updating a source, commit the changed files:

```bash
git add docs/llm-wiki-llm-wikis/raw/llm-wiki.md docs/llm-wiki-llm-wikis/raw/llm-wiki.md.dvc
git commit -m "Track llm-wiki source with DVC"
```

### Current example

The existing example in this repo is:

- imported file: `docs2/llm-wiki.md`
- DVC file: `docs2/llm-wiki.md.dvc`
- source URL: `https://gist.githubusercontent.com/karpathy/442a6bf555914893e9891c11519de94f/raw`

<!-- llm-wiki-init:v1:readme:end -->
