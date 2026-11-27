---
name: ui-consistency-audit
description: Read-only audit of a frontend codebase against its own design system. Finds UX done different ways for the same job, repeated markup that should be a shared component, patterns missing from the design docs, values with no token, and gaps in the system itself. Use when asked to review design-system consistency, find inconsistent patterns, look for components to extract, or check for untokenised values.
---

# UI Consistency Audit

Compare what the code does with what the design system says. Change nothing in the audited repository: the output is a report and, if asked, draft tracker issues.

## 1. Find the source of truth

Read these before you search:

- The design doc (`DESIGN.md`, a design-system README, or Storybook docs pages) and any product brief.
- The token definitions: CSS custom properties, a Tailwind `@theme` block or config, or token JSON.
- The shared component package and what its index actually exports.
- Where stories live, and how they are organised.

Write down the rules the doc states in absolute terms ("never", "every", "only"). Each one is a check you will run.

If there is no design doc or token file, say so, and audit consistency between screens only.

## 2. Mechanical sweeps

Run these over source files, leaving out stories, tests and generated code. Count each value and note where it lives (shared primitives or app code). Use `rg` with `--glob`, and quote paths: unquoted `[id]` segments are read as shell glob patterns.

| Sweep                  | What to look for                                                                                                                                            |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Colour                 | hex, `rgb()` and `oklch()` literals; framework palette classes (`bg-blue-500`); legacy or duplicate semantic tokens                                         |
| Opacity and tints      | `token/NN` modifiers and `color-mix` percentages. Repeated steps are missing semantic tokens (notice background, focus ring, scrim).                        |
| Arbitrary values       | `-[...]` classes or inline `style`, grouped by property: widths, grid templates, radii, shadows                                                             |
| Type                   | sizes and weights outside the documented scale, and section-heading class combinations                                                                      |
| Spacing                | the spread of padding and gap values, and whether the doc's spacing tokens exist in code                                                                    |
| Radius, shadow, motion | radii outside the scale, any shadows (especially inset stripes), durations and easings                                                                      |
| Copied constants       | class strings redefined in several files (`const micro = …`, link styles), and long class strings pasted 2+ times                                           |
| Formatters             | money, date and number helpers. Compare their units (for money: minor units or whole), sign handling (minus character, sign at zero) and naming collisions. |
| Primitives             | variants and sizes the doc forbids, double skins (old theme plus overrides), and missing exports                                                            |
| Stories                | shared components that no story imports                                                                                                                     |

## 3. Pattern survey by purpose

List the jobs the UI does more than once, then find every implementation of each. A survey that sweeps many files can go to a read-only subagent. Give it this list and the paths, tell it what you have already found, and ask for `file:line` evidence.

- List rows: container, dividers, padding, column layout, how the name links, numeric or currency alignment and tabular numerals, how a row collapses on phones
- Filter and search bars: submit or live filtering, where Clear sits and what it says, how hidden or archived items are shown, date or period pickers
- Editing: inline cell editor, drawer or dialog, disclosure, inline toggle, dedicated page. Map each action (for example rename, set a field, add a record) to the pattern used for it.
- Destructive flows: confirm or not, which button variant, whether it explains what happens
- Feedback after saving: a banner after a redirect, an inline status, a toast, or nothing visible
- Empty, no-results and loading states: heading level, alignment, container, whether there is an action
- Submit buttons: pending state, label wording, Cancel style, order and alignment
- Page frames: width variants, headers, back links, section headings
- Containers: the documented panel or card compared with hand-built copies, and two container systems doing the same job

Spot-check a sample of the subagent's claims against the code before you report them.

## 4. Report

Use five sections, in this order. Cite every finding with a `file:line` link, and give a count where you have one.

1. **The same job done different ways**: a table with the job, the variants found and a suggested resolution.
2. **Should be shared components**: things repeated 3 or more times with the same purpose. Lead with the ones that remove the most variants.
3. **Patterns missing from the design language**: recurring decisions the doc never makes, and places where code breaks a "never" rule.
4. **Values with no token**: grouped as colour/tint, spacing, motion, layout, type and radius.
5. **Gaps in the system itself**: primitives, exports, dead theme layers, story coverage, and drift between the doc and the code.

End with the recommended order of work: decisions first, because they unblock migrations, then the extractions that remove the most variants. Also say what you didn't check, such as running the app or reading particular files row by row.

## 5. Draft tracker work (only when asked)

Follow the target repository's issue conventions. With no conventions, use these:

- One epic with a plain-language outcome, plus one task per pull request.
- Make the design decisions (which confirm pattern, which feedback mechanism, and so on) a human-owned task that blocks the migrations it gates.
- Put tasks that fit an existing epic under that epic, and list the epics you ruled out.
- Each task needs its scope, the files involved, acceptance criteria, and the stories to add or update.

Put drafts in the reply or in a scratch or temp directory outside the audited repository. File them only when the user says to.

## Avoid

- Proposing an extraction for something used once or twice, or for things that look alike but have different purposes.
- Reporting a value as untokenised when the doc deliberately leaves it local (for example a one-off chart dimension).
- Restating the doc's rules without evidence that code breaks them.
- Editing code, tokens or docs, or writing any file into the audited repository, during the audit.
