---
name: implement
description: "Build a ticket from the issue tracker the modemax way: read it, claim it, turn its acceptance criteria into success criteria, run the matching modemax playbook, review against the ticket, and open a PR that closes it. Use for /implement, \"implement #42\", \"build this ticket\", \"next ticket\", or any request that names a ticket to build."
---

# Implement

A ticket is the contract between shaping and building. This skill reads that contract and hands it to the **modemax** skill's playbooks, so the build is verified against what the ticket asked for.

The issue tracker comes from the repo's `## Agent skills` block in `CLAUDE.md` or `AGENTS.md`, which points at `docs/agents/issue-tracker.md`. If it is missing, tell the user to run `/setup-modemax` and stop.

## 1. Pick the ticket

- **A ticket was named** (`#42`, an issue URL, a `.scratch/` ticket file): use it. If the reference is ambiguous, ask.
- **"Next ticket" or no ticket:** list the open `ready-for-agent` tickets with no open blockers and no assignee, and take the first in dependency order. Under a parent issue or spec, stay inside it. Say which one you took and why.

Read the full body and comments, and every blocking ticket's resolution. State the ticket's title before starting.

## 2. Check that it is buildable

The ticket must be open, carry no open blocker, and have acceptance criteria. When a blocker is still open, stop and name it. When the acceptance criteria are missing or vague, do not guess them: comment on the ticket with the specific questions, move it to `needs-info` per the triage labels, and stop. That is the **triage** skill's job, not a build.

## 3. Claim it

Assign the ticket to the user driving the session (`gh issue edit <n> --add-assignee @me` on GitHub, the tracker doc's equivalent elsewhere), so a parallel session skips it. Work on a branch named for it, such as `<n>-<slug>`.

## 4. Build it through modemax

Invoke the **modemax** skill and match the playbook from the ticket's category: Feature for `enhancement`, Bug fix for `bug`, Refactoring for a prefactor or behavior-preserving ticket. Carry these into the playbook:

- The user's goal is the ticket's "What to build". Restate it per modemax's first-message trigger.
- The success criteria are the ticket's acceptance criteria, copied verbatim into every delegate brief and checked one by one at the playbook's verify step.
- The test seams are the ones the ticket or its parent spec names. The **tdd** skill builds at them.
- Scope is the ticket. Work the ticket does not ask for becomes a new ticket, not a bigger diff.

## 5. Review against the ticket

Before opening the PR, run the **two-axis-review** skill from the branch's merge base, with the ticket as its spec source. Fix what the Spec axis reports as missing or wrong. Report scope creep and keep it out of the PR.

## 6. Ship and close the loop

Run the playbook's **Opening a PR** step. The PR's `## Why` ends with `Closes #<n>` (the forge's closing keyword), so merging closes the ticket. Comment on the ticket with the PR link.

**Reply:** the ticket title and link, each acceptance criterion with the evidence that it holds, the PR link, and the tickets this one unblocks once it merges.
