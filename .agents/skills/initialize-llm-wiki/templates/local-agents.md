# LLM Wiki — Agent Guide


<!-- llm-wiki-init:v1:local:start -->
<!-- llm-wiki-template-version:1 -->


## Wiki: <DISPLAY_TOPIC>


**Root:** `<WIKI_ROOT>/`


### Purpose


This is a narrow, topic-focused knowledge base. All research, synthesis, and documentation
about `<DISPLAY_TOPIC>` lives here. Consult it before answering questions on this topic.


### Folder structure


| Path                        | Purpose                                            |
| --------------------------- | -------------------------------------------------- |
| `<WIKI_ROOT>/raw/`          | Immutable source documents — never modify          |
| `<WIKI_ROOT>/wiki/`         | Curated, interlinked pages maintained by the agent |
| `<WIKI_ROOT>/wiki/index.md` | Table of contents for the entire wiki              |
| `<WIKI_ROOT>/wiki/log.md`   | Append-only record of all operations               |
| `<WIKI_ROOT>/templates/`    | Reusable page templates                            |


### Ingest workflow


When the user adds a new source to `<WIKI_ROOT>/raw/` and asks you to ingest it:


1. Read the full source document
2. Discuss key takeaways with the user before writing anything
3. Create a summary page in `<WIKI_ROOT>/wiki/` named after the source
4. Create or update concept pages for each major idea or entity
5. Add wiki-links ([[page-name]]) to connect related pages
6. Update `<WIKI_ROOT>/wiki/index.md` with new pages and one-line descriptions
7. Append an entry to `<WIKI_ROOT>/wiki/log.md` with the date, source name, and what changed


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


When the user asks a question about `<DISPLAY_TOPIC>`:


1. Read `<WIKI_ROOT>/wiki/index.md` first to find relevant pages
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


- **Never** modify anything in `<WIKI_ROOT>/raw/`
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
<!-- llm-wiki-init:v1:local:end -->



