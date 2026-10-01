---
name: scope-router
description: Route a new idea or capability to the right ownership boundary before design or implementation. Use when it may belong to an existing Project, a new Project, the harness, a skill, a plugin, an automation, or multiple boundaries.
disable-model-invocation: true
---

# Scope Router

Decide where the work belongs before choosing a build flow.

## Repository-scope gate

Run this gate before opening an issue, creating a branch, or creating a
worktree:

1. Inventory every repository the session may modify, including the harness,
   child projects, skill-source repositories, and plugin/package repositories.
2. Classify each repository as an existing project, new project, harness
   change, external dependency/skill source, or temporary checkout.
3. Register every durable project in the harness public or local project
   configuration before creating tracker work or worktrees. Use the
   harness-managed clone/worktree for later edits.
4. Record the repository and project classification in the handoff or work
   notes, then continue to issue and branch selection.

Do not treat a repository as a one-off dependency when the session edits it or
expects to reuse it. Keep third-party sources and temporary checkouts outside
the durable project inventory.

## Inspect

Read the local `AGENTS.md` and `CONTEXT.md` first. Then inspect the project inventory, wiki inventory, relevant decision records, available skills, and skill lock/source metadata. Use lockfiles to distinguish locally authored skills, installed dependencies, and external skills before recommending a direct edit or wrapper. Treat these files as evidence about ownership and constraints, not as permission to mutate anything.

## Classify

Choose one or more ownership boundaries:

- existing Project;
- new Project;
- harness enhancement;
- harness-owned skill;
- external skill wrapper;
- plugin or integration;
- scheduled routine or automation;
- split effort across boundaries;
- no implementation yet.

Prefer an existing Project only when its declared purpose and topics clearly cover the request. Recommend a new Project when the request has an independent domain, lifecycle, privacy boundary, or issue history. Put cross-project policy, orchestration, secure-record behavior, and shared workflow in the harness. Put repeatable agent procedure in a harness-owned skill. Keep external skill changes out of the local source tree; add a thin wrapper only when local policy or sequencing must surround the external capability.

## Report

Return a compact scope memo:

1. recommended home;
2. evidence from the inspected configuration;
3. affected repositories or surfaces;
4. privacy, data-lifecycle, or authorization concerns;
5. split work and dependencies;
6. the next recommended skill or human decision.

Do not create a repository, edit configuration, install a skill, open an issue, or schedule an automation. If ownership remains ambiguous, ask one focused question at a time. Once the boundary is clear, hand off to the appropriate design or implementation flow.
