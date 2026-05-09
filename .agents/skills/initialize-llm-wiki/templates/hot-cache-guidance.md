## Hot Cache


**Performance optimization for repeated interactions.**


### What is it?


Hot cache (`wiki/hot.md`) stores ~500 recent context characters to avoid unnecessary wiki page reads on follow-up queries. Useful when:


- Agent interacts with this wiki repeatedly (e.g., executive assistant, personal collaborator)
- Follow-up questions likely reference recently discussed topics
- Token efficiency is a priority


**Not needed for**: One-off research, static vaults, or documentation-lookup wikis.


### When to use


✅ **Use hot cache if:**


- You're building an assistant that returns to this wiki multiple times per session
- You have repeated Q&A about recent context
- Example: Personal second brain connected to an exec assistant


❌ **Skip hot cache if:**


- One-off research or investigation tasks
- Static reference vaults (e.g., transcript library)
- New wiki, not yet in use


### How to use


**For agents:**


1. Before querying full wiki pages, check `wiki/hot.md`
2. If recent context matches the follow-up query, use cached data
3. Skip full wiki crawl → save tokens


**For users:**


1. Optionally update `hot.md` with recent context after major queries
2. Clear it when shifting to new topics
3. Agents will auto-update it over time


### Examples


**Example 1: Exec assistant**


> User asked about Q2 metrics yesterday. On today's follow-up ("any updates?"), agent checks hot cache, finds Q2 context, avoids re-reading 50 wiki pages.


**Example 2: Research vault**


> User researching YouTube transcripts once per week. Hot cache not useful — skip it.


### Token impact


- With cache: Follow-up questions → ~100 tokens (cache check + delta)
- Without cache: Follow-up questions → ~500+ tokens (full wiki scan)
- Savings: ~80% on repeated queries


---


**Next step**: After each session, agents can append cache updates to `wiki/hot.md` for continuity.



