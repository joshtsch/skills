---
name: agent-system-audit
description: Audit an agent session or its initial context lifecycle for evidence-backed improvements to skills, prompts, policies, tools, plugins, configuration, and handoffs. Use explicitly after a session or before a new workflow when context load and skill sprawl need review.
disable-model-invocation: true
---

# Agent System Audit

Review the agent system as a whole. Produce a small, evidence-backed candidate list; do not edit the system automatically.

## Modes

Choose one mode:

- **Session retrospective** — inspect the completed session, its handoffs, artifacts, tool use, repeated decisions, misroutes, and user corrections.
- **Initial context audit** — inspect what is loaded or reachable across the session lifecycle: instruction files, project configuration, skill descriptions and bodies, plugin and tool manifests, memory or handoff surfaces, phase transitions, and recurring automations.

If the user does not specify a mode, infer it from whether they supplied a completed session or are preparing a workflow. Say which mode you used.

## Inspect

Read the applicable `AGENTS.md`, `CONTEXT.md`, project configuration, skill inventory, lockfiles, plugin manifests, and relevant ADRs. Compare source skill state with installed skill state when both are available. For a session retrospective, inspect only available session artifacts and outputs; never require raw transcripts, credentials, PII, or raw external payloads.

Map each surface by lifecycle behavior:

- always loaded;
- loaded when a trigger fires;
- loaded only at a phase boundary;
- produced as transient state;
- durable configuration or policy.

Distinguish observed behavior from inference. Mark unavailable context instead of pretending to have inspected hidden model or host state.

## Find opportunities

Look for:

- repeated workflows with no clear skill;
- skills that overlap enough to combine;
- skills that should become explicit-only to reduce context load;
- skills whose descriptions misroute or trigger too broadly;
- instructions that belong in a disclosed reference instead of always-loaded context;
- stale, duplicated, contradictory, or orphaned guidance;
- missing handoff, confirmation, privacy, ownership, or verification checkpoints;
- plugin or tool configuration that belongs at a different scope;
- automations or routines that should remain candidates rather than run automatically;
- durable policy that is living only in conversational habit.

Prefer deletion, combination, narrowing, demotion, or pointer improvement before proposing a new skill. Recommend a new skill only when the workflow is repeated or clearly durable, has a distinct trigger, contains non-obvious guidance, and has no existing owner.

Keep the skill count flat by default: every proposed addition must name one candidate to remove, combine, or demote, or explain why no existing surface can own the behavior.

## Report

Return at most five prioritized candidates. For each include:

1. evidence and affected lifecycle surface;
2. failure or cost;
3. smallest change;
4. ownership and affected repository;
5. confidence;
6. a verification experiment or acceptance condition.

Classify each candidate as one of:

- add skill;
- update skill;
- combine skills;
- make skill explicit-only or model-invoked;
- update instruction or policy;
- move detail behind a pointer;
- change tool/plugin/config scope;
- add lifecycle checkpoint;
- remove stale guidance;
- no change.

End with a recommended order and a short “do not change” section for tempting ideas that lack evidence. Do not create files, install skills, change configuration, open issues, or schedule work unless the user separately confirms a specific candidate.
