# Contributing

Create or identify the originating issue before creating a feature branch. Include
the issue number in the branch name when the provider supports it. Keep skill
source in this repository; install it into a harness separately with the Skills
CLI after the source change is ready.

If the issue tracker is unavailable, record a redacted outage handoff with the
intended title, attempted operation, timestamp, and exact blocker. Treat the
branch as provisional: do not push or open a change request until the issue
exists and is linked. A local commit is allowed only when the user explicitly
authorizes a provisional commit, and it must not be presented as review-ready.

Preserve unrelated working-tree changes. Do not commit generated files, local
environment files, credentials, or personal data. Validate changed skill
frontmatter and run the applicable skill checks before handoff.
