# LLM Wiki - Agent Guide


<!-- llm-wiki-init:v1:local:start -->
<!-- llm-wiki-template-version:1 -->


## Wiki: llm-wikis


**Root:** `docs/llm-wiki-llm-wikis/`


### Purpose


This is a narrow, topic-focused knowledge base. All research, synthesis, and documentation
about `llm-wikis` lives here. Consult it before answering questions on this topic.


### Folder structure


| Path                                   | Purpose                                            |
| -------------------------------------- | -------------------------------------------------- |
| `docs/llm-wiki-llm-wikis/raw/`         | Immutable source documents - never modify          |
| `docs/llm-wiki-llm-wikis/wiki/`        | Curated, interlinked pages maintained by the agent |
| `docs/llm-wiki-llm-wikis/wiki/index.md`| Table of contents for the entire wiki              |
| `docs/llm-wiki-llm-wikis/wiki/log.md`  | Append-only record of all operations               |
| `docs/llm-wiki-llm-wikis/templates/`   | Reusable page templates                            |


### Ingest workflow


When the user adds a new source to `docs/llm-wiki-llm-wikis/raw/` and asks you to ingest it:


1. Read the full source document
2. If the source is raw HTML, first create a temporary Markdown reading view for ingestion using `mdream`:

   ```bash
   cat docs/llm-wiki-llm-wikis/raw/<file>.html \
     | npx mdream --preset minimal --origin <canonical-url-if-known> \
     > /tmp/<file>.normalized.md
   ```

   - Prefer `mdream` for raw HTML because its `minimal` preset isolates main content and filters navigation, forms, buttons, and footers, which reduces token cost for ingest.
   - If `npx mdream` is unavailable, use `pandoc -f html -t gfm` as a fallback, but expect noisier output because it converts markup without article extraction.
   - Never overwrite the raw source in `docs/llm-wiki-llm-wikis/raw/`; the normalized Markdown is only a temporary ingest artifact unless the user explicitly asks to track it separately.
3. Discuss key takeaways with the user before writing anything
4. Create a summary page in `docs/llm-wiki-llm-wikis/wiki/` named after the source
5. Create or update concept pages for each major idea or entity
6. Add wiki-links ([[page-name]]) to connect related pages
7. Update `docs/llm-wiki-llm-wikis/wiki/index.md` with new pages and one-line descriptions
8. Append an entry to `docs/llm-wiki-llm-wikis/wiki/log.md` with the date, source name, and what changed


A single source may touch many wiki pages. That is normal.


### Page format


Every wiki page must follow this structure:


```markdown
# Page Title


**Summary**: One to two sentences describing this page.


**Sources**: List of raw source files this page draws from.


**Last updated**: YYYY-MM-DD


---


Main content. Use clear headings and short paragraphs.
Link related concepts using [[wiki-links]] throughout.


## Related pages


- [[related-concept]]
```


### Citation rules


- Every factual claim must reference its source file: `(source: filename)`
- If two sources disagree, note the contradiction explicitly
- If a claim has no source, mark it `(source: unverified)`


### Question answering


When the user asks a question about `llm-wikis`:


1. Read `docs/llm-wiki-llm-wikis/wiki/index.md` first to find relevant pages
2. Read those pages and synthesize an answer
3. Cite specific wiki pages in your response
4. If the answer is not in the wiki, say so clearly
5. If the answer is valuable, offer to save it as a new wiki page


### Lint


When the user asks you to lint or audit the wiki:


- Check for contradictions between pages
- Find orphan pages (no inbound links)
- Identify concepts mentioned without their own page
- Flag claims that may be outdated
- Check for missing cross-links between closely related pages
- Check whether wiki has become too broad or large to stay effective as one topic-scoped wiki
- Check all pages follow the page format above
- If wiki scope is too broad or source count is well beyond roughly 100 documents, recommend splitting it into narrower topic wikis
- Report findings as a numbered list with suggested fixes


### Rules


- **Never** modify anything in `docs/llm-wiki-llm-wikis/raw/`
- Always update `index.md` and `log.md` after any changes
- Keep page names lowercase with hyphens (e.g. `my-concept.md`)
- Write in clear, plain language
- When uncertain about categorization, ask the user


### Wiki scope guidance


- Keep each wiki narrowly scoped and topic-focused
- Target roughly 100 source documents per wiki for best retrieval quality
- Split broad wikis into smaller topic wikis when scope expands
- Access wikis as needed, not on every prompt
- Lint wikis regularly to keep links, claims, and coverage healthy


## Hot Cache


**Performance optimization for repeated interactions.**


### What is it?


Hot cache (`wiki/hot.md`) stores ~500 recent context characters to avoid unnecessary wiki page reads on follow-up queries. Useful when:


- Agent interacts with this wiki repeatedly (e.g., executive assistant, personal collaborator)
- Follow-up questions likely reference recently discussed topics
- Token efficiency is a priority


**Not needed for**: One-off research, static vaults, or documentation-lookup wikis.


### When to use


Use hot cache if:


- You're building an assistant that returns to this wiki multiple times per session
- You have repeated Q&A about recent context
- Example: Personal second brain connected to an exec assistant


Skip hot cache if:


- One-off research or investigation tasks
- Static reference vaults (e.g., transcript library)
- New wiki, not yet in use


### How to use


**For agents:**


1. Before querying full wiki pages, check `wiki/hot.md`
2. If recent context matches the follow-up query, use cached data
3. Skip full wiki crawl to save tokens


**For users:**


1. Optionally update `hot.md` with recent context after major queries
2. Clear it when shifting to new topics
3. Agents will auto-update it over time


### Examples


**Example 1: Exec assistant**


User asked about Q2 metrics yesterday. On today's follow-up ("any updates?"), the agent checks hot cache, finds Q2 context, and avoids re-reading many wiki pages.


**Example 2: Research vault**


User researching YouTube transcripts once per week. Hot cache not useful, skip it.


### Token impact


- With cache: Follow-up questions need only a cache check plus delta
- Without cache: Follow-up questions require a broader wiki scan
- Savings are highest when recent context remains relevant


---


**Next step**: After each session, agents can append cache updates to `wiki/hot.md` for continuity.
<!-- llm-wiki-init:v1:local:end -->
