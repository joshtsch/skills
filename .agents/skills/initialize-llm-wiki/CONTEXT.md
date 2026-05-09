# Initialize LLM Wiki Rollout Context


Canonical language for org-wide release decisions for the initialize-llm-wiki skill.


## Language


**Root-Level Mutation Policy**:
Whether initialization may modify root AGENTS and root README files.
_Avoid_: automatic root edits, always-on root mutation


**Opt-In Root Edits**:
Default policy where root AGENTS and README updates require explicit consent.
_Avoid_: implicit root updates, forced root writes


**Dry-Run Preview Mode**:
A no-write execution that shows exactly what files and managed blocks would change.
_Avoid_: silent write, blind apply


**Post-Init Integrity Check**:
A validation pass after scaffold that confirms required files, marker balance, and inventory row presence.
_Avoid_: write-only success, no validation


**Configurable Wiki Base Path**:
A user-selected base directory for wiki placement, with docs as the default.
_Avoid_: docs-only placement, fixed root path


**Versioned Managed Marker Contract**:
A standardized, versioned marker scheme used consistently across local guide, root agent, and readme managed blocks.
_Avoid_: marker drift, unversioned markers, file-specific marker variants


**Deterministic Slug Safety**:
Rules that prevent normalized topic slug collisions and reserved-name conflicts before initialization writes.
_Avoid_: ambiguous slug ownership, accidental directory overlap


**Release-Grade Run Audit Trail**:
A structured initialization run record that is always emitted, including dry-runs and no-op outcomes.
_Avoid_: missing run history, unstructured change narratives


**Template Version Pinning**:
Metadata that binds a wiki scaffold to a specific template version and enables explicit migration workflows.
_Avoid_: silent scaffold drift, uncontrolled template upgrades


**Org Baseline Mode**:
An enforced initialization policy that requires all release safeguards and blocks execution when a required check is skipped.
_Avoid_: optional safety controls, inconsistent per-user rollout behavior


## Relationships


- **Opt-In Root Edits** gates whether **Root-Level Mutation Policy** allows root file changes.
- **Dry-Run Preview Mode** runs before any write and feeds user confirmation.
- **Post-Init Integrity Check** runs after writes and validates scaffold correctness.
- **Configurable Wiki Base Path** determines where new wiki roots are created and discovered.
- **Versioned Managed Marker Contract** stabilizes reruns and migration behavior across skill versions.
- **Deterministic Slug Safety** protects unique wiki identity during topic normalization.
- **Release-Grade Run Audit Trail** captures operation outcomes and warnings for traceability.
- **Template Version Pinning** enables controlled upgrades of existing wiki scaffolds.
- **Org Baseline Mode** enforces mandatory safeguards for predictable org-wide operation.


## Example dialogue


> **Dev:** "Can we just initialize in docs and patch root files automatically?"
> **Domain expert:** "No. We use **Opt-In Root Edits** and start with **Dry-Run Preview Mode** so teams can approve changes first."


## Flagged ambiguities


- "safe to rerun" was overloaded between idempotent writes and governance safety. Resolved: idempotency and policy-safe behavior are separate requirements.
- "managed markers" was used to mean both marker identity and marker format stability. Resolved: these are unified under **Versioned Managed Marker Contract**.
- "topic name" was used interchangeably with slug and display name. Resolved: display topic is user-facing, slug identity is governed by **Deterministic Slug Safety**.
- "ownership-aware updates" was evaluated as a rollout safeguard. Resolved: rejected for initial release; continue with existing write model plus explicit user confirmation controls.
- "wiki log" was used to describe both content-change history and tool execution records. Resolved: tool executions are captured via **Release-Grade Run Audit Trail**.
- "rerun" was used to mean both idempotent no-op and intentional scaffold upgrade. Resolved: upgrades require **Template Version Pinning** and explicit migration confirmation.
- "best practice" was used as guidance rather than policy. Resolved: accepted safeguards are mandatory under **Org Baseline Mode**.



