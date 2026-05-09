# Wiki Inventory Rules


Use before writing root README managed block.


Inputs:


- `BASE_PATH` (default `docs`)


## Discover wikis


Scan `<BASE_PATH>/` for:


- `<BASE_PATH>/llm-wiki`
- `<BASE_PATH>/llm-wiki-*`


## Build table row values


For each wiki dir:


1. Topic


- `<BASE_PATH>/llm-wiki` -> `Project Knowledge Base`
- `<BASE_PATH>/llm-wiki-<slug>` -> title-case from kebab slug


2. Location


- Wiki root path, e.g. `docs/llm-wiki-kubernetes/`
- Wiki root path, e.g. `<BASE_PATH>/llm-wiki-kubernetes/`


3. Guide


- `<WIKI_ROOT>/AGENTS.md`


4. Last Updated


- Primary: latest heading date in `<WIKI_ROOT>/wiki/log.md` matching `## [YYYY-MM-DD] ...`
- Fallback: file modification date of `<WIKI_ROOT>/wiki/log.md`
- Final fallback: `unknown`


## Ordering


Sort rows alphabetically by wiki location.



