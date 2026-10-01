---
name: harness-grill-with-docs
description: Grill a design with durable domain docs while applying harness project-boundary, privacy, and handoff rules. Use instead of the upstream grill-with-docs skill when working in or around the harness.
disable-model-invocation: true
---

# Harness Grill with Docs

Use the installed upstream `grill-with-docs` skill from `mattpocock/skills` as the interview and domain-modeling engine. This skill supplies only the harness-specific boundary rules; do not copy or replace the upstream interview procedure.

## Before the interview

Run `scope-router` when the request may belong to an existing Project, a new Project, the harness, a skill, a plugin, an automation, or multiple boundaries. Resolve the owning context before writing a glossary or ADR.

If the target is not yet a Project, keep transient design notes and handoffs under the harness `docs/.scratch/`. Do not add target-domain vocabulary to the harness `CONTEXT.md` merely because the discussion started in the harness repository.

## During the interview

- Follow the upstream grilling and domain-modeling workflow.
- Ask one question at a time when the user requests that interaction mode; otherwise preserve the upstream frontier-round behavior.
- Treat `secure record` as the harness domain term and `secure note` as a provider storage mechanism unless the user resolves that distinction differently.
- When discussing source ingestion, separate local uncommitted staging from durable raw sources. Sensitive inputs use the harness secure-record workflow and never become tracked wiki content, logs, generated artifacts, or committed raw sources.
- Keep each glossary and ADR change in the repository that owns the domain or decision. If ownership is still unsettled, record only a transient handoff.
- When a design splits across boundaries, name each resulting effort and its dependency explicitly.

## Completion

Do not implement, create a Project, modify harness configuration, install skills, or schedule an automation until the upstream grilling session reaches shared understanding and the user confirms it.

At a boundary that needs another session, create a redacted handoff in the operating system temporary directory and include the next recommended skills. Prefer a handoff over placing target-project design material in the harness repository.
