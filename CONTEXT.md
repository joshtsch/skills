# Knowledge Sync

This context covers how externally sourced documents are identified, stored, versioned, and synchronized into local wiki raw-document directories.

## Language

**Source**:
An external document origin identified by a canonical URL.
_Avoid_: package, dependency

**Snapshot**:
An immutable byte-for-byte capture of a Source at a point in time, identified by its content digest.
_Avoid_: version, release

**Local Cache**:
The local content-addressed store of Snapshots used to avoid unnecessary refetching and support local reads.
_Avoid_: registry, raw docs

**Registry**:
A remote content-addressed blob store that persists Snapshots and their source metadata.
_Avoid_: package registry, mirror

**Sync**:
A successful synchronization fetches a Snapshot, persists it to the Registry, updates the Local Cache, and then materializes the destination file.
_Avoid_: local-only refresh, best-effort pull

**Refresh**:
An explicit operation that re-fetches a Source to discover whether a new Snapshot should be added to its lineage.
_Avoid_: sync, install

**Promotion**:
An explicit operation that advances the lockfile to pin a chosen Snapshot for future Sync operations.
_Avoid_: refresh, auto-update

**Lock Entry**:
The repo-local record that pins which Snapshot a Source should materialize, along with destination metadata.
_Avoid_: manifest, history log

**Knowledge Config**:
The user-authored configuration file that declares which Sources should be tracked and how they should materialize locally.
_Avoid_: lockfile, registry manifest

**Source Manifest**:
The Registry record that tracks the Snapshot lineage for a Source across time.
_Avoid_: lock entry, package metadata

**Convergence**:
The act of making lock state and materialized files match the desired tracking state declared in the Knowledge Config.
_Avoid_: refresh, promotion

**Registration**:
The act of adding or removing a Source's Lock Entry from the lockfile, adopting registry-known content when available and creating an initial Snapshot only when the Source is new to the Registry.
_Avoid_: sync, refresh, promotion

**Edit**:
The act of changing a Lock Entry's materialization metadata and rematerializing the pinned Snapshot to the new destination.
_Avoid_: refresh, promotion

## Relationships

- A **Source** may produce many **Snapshots**
- A **Snapshot** belongs to exactly one **Source** lineage even if identical bytes may deduplicate physically
- A **Local Cache** stores zero or more **Snapshots**
- A **Registry** stores zero or more **Snapshots**
- A **Sync** succeeds only after the **Registry** durably stores the **Snapshot**
- A **Refresh** may produce a new **Snapshot** for an existing **Source**
- A **Sync** reproduces a known **Snapshot**; a **Refresh** discovers a possible new one
- A **Promotion** selects which **Snapshot** a **Lock Entry** pins
- A **Source Manifest** records the lineage of **Snapshots** for a **Source**
- A **Lock Entry** does not own snapshot history; it references one chosen **Snapshot**
- A **Knowledge Config** declares desired tracking state; a **Lock Entry** records resolved pinned state
- **Convergence** aligns the lockfile and materialized files to the **Knowledge Config**
- A **Registration** changes whether a **Source** is tracked by a **Lock Entry**
- A new **Registration** pins the Registry's latest known **Snapshot** for a **Source** when one exists
- A new **Registration** creates an initial pinned **Snapshot** only when the **Source** is absent from the **Registry**
- An existing **Lock Entry** blocks repeat **Registration** for the same **Source**
- An **Edit** updates a **Lock Entry** and rematerializes its pinned **Snapshot**
- An **Edit** reads from the **Local Cache** first and the **Registry** second; it does not contact the original **Source**
- During **Convergence**, Sources removed from **Knowledge Config** are removed from the lockfile and their materialized destination files are deleted
- During **Convergence**, Sources added to **Knowledge Config** may adopt existing Registry state but do not fetch from the internet implicitly

## Example dialogue

> **Dev:** "When we fetch a new **Source**, do we write the raw file directly into the wiki?"
> **Domain expert:** "No. We first materialize a **Snapshot**, then persist it in the **Registry**, and only then sync it into the local raw-docs destination."

## Flagged ambiguities

- "registry" was initially ambiguous between a package-style index and a blob store — resolved: **Registry** means a remote content-addressed blob store
- "sync" could have meant a local file refresh even when remote persistence failed — resolved: **Sync** is write-through and fails if the **Registry** write fails
- "sync" and "refresh" could have been conflated — resolved: **Sync** reproduces pinned content, while **Refresh** is the only operation that checks a Source for newer content
- "refresh" and lockfile updates could have been conflated — resolved: **Refresh** discovers new Snapshots, while **Promotion** is the separate act of advancing the pinned Snapshot in a **Lock Entry**
- "add/remove source" could have been conflated with fetching content — resolved: **Registration** is lockfile membership management, distinct from **Refresh**, **Sync**, and **Promotion**
- "register existing source" could have implied another initial write — resolved: **Registration** is first-time only and must not write to the **Registry** when a **Lock Entry** already exists for that **Source**
- "register new source" could have implied mandatory internet fetch — resolved: **Registration** adopts the Registry's latest known **Snapshot** first, and only fetches from the internet when the **Registry** has never seen that **Source**
- "edit" could have meant metadata-only mutation — resolved: **Edit** rematerializes from the pinned **Snapshot**, preferring the **Local Cache** and falling back to the **Registry**, without inspecting old destination bytes
- "configuration" and "lock state" could have been conflated — resolved: **Knowledge Config** is user-authored desired state, while the lockfile stores resolved pinned state
- "sync" could have meant only file writes — resolved: **Convergence** through sync updates lock state in both directions and removes materialized outputs no longer declared in **Knowledge Config**
