---
name: save
description: Save the live work session as a portable handoff with explicit decisions and open questions. Use when the user says "save" or asks to hand off or resume work across sessions or providers.
---

# Save a session

Create a concise, provider-neutral checkpoint from the current conversation and repository state. The harness CLI stores it in Supabase; do not treat a local ignored file or a provider-native handoff as the durable copy.

1. Summarize the goal, current state, completed work, important file or issue references, verification, blockers, and concrete next actions. Exclude raw transcripts, credentials, and unrelated personal details.
2. Write explicit decisions with rationale in a separate artifact. Mark unresolved questions as open; keep tentative ideas out of the settled-decision list. Include useful outputs only when they are not already represented by the handoff or decisions.
3. If continuing a claimed session, use the protected checkpoint path returned by `pnpm resume`; never copy its owner token. Otherwise let the CLI create a new session key. The CLI embeds the opaque key in the encrypted handoff and returns it for continuation.
4. Materialize the artifact inputs in a private temporary directory, not an ignored repository directory. Restrict access to the current user and remove the plaintext inputs after the command finishes, whether it succeeds or fails. Invoke the harness from its root:

   ```sh
   pnpm save -- --handoff <handoff-file> [--decisions <decisions-file>] [--outputs <outputs-file>] [--projects-local <projects-local-file>] [--checkpoint-file <resume-checkpoint-file>]
   ```

   Add `--projects-local` only when portable private project metadata changed. Machine paths and credentials are filtered; the encrypted user-level Supabase record is separate from the session artifacts.
5. Confirm the command reports `saved` before treating the checkpoint as resumable. If it reports `queued`, the encrypted temporary intent is not yet resumable; preserve it and report that `pnpm continuation:flush` is required once Supabase is reachable.
6. If a live resumed session needs more time, use `pnpm continuation:renew -- --checkpoint-file <resume-checkpoint-file>`. Saving releases the claim and removes the local checkpoint. A new provider or machine resumes with the session key embedded in the handoff and receives a fresh lease.

At a genuine finalization point, run `agent-system-audit` only when the user requested an evaluation or the session workflow calls for one. Store its candidate report with `pnpm save:audit -- --session-key <key> --report <report-file>`; when the current process holds a live claim, pass its `--checkpoint-file` instead of `--session-key`. The result is review-only. Ordinary saves do not run an audit or promote suggestions into policy.
