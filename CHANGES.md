# CHANGES

This file is the release changelog, with one `## <version> - <title>` entry per release, newest first.

## 0.1.0 - modemax: pstack's way of building, Matt Pocock's way of shaping

modemax merges two MIT-licensed skill suites into one plugin with one router.

The base is the [pstack-claude](https://github.com/michael-denyer/pstack-claude) port at `190fc9a` (0.9.111), with its multi-runtime packaging for Claude Code, Codex, Pi, GitHub Copilot, Muse, and shared Agent Skills installs. Its history is in [its change log](https://github.com/michael-denyer/pstack-claude/blob/190fc9a009491cbcfc04e25ef5b3c2d1fcf5ca8a/CHANGES.md).

- `poteto-mode` becomes `modemax`, `poteto-agent` becomes `modemax-agent`, `poteto-help` becomes `modemax-help`, and `setup-pstack` becomes `setup-modemax`. The model sheet is `modemax-models.md`.
- The router gains three phases (Shape, Build, Ship) with the issue-tracker ticket as the contract between them, a phase-dependent rule for when to ask the user, and a Shaping playbook.
- New `implement` skill: reads a ticket, claims it, runs the matching playbook with the ticket's acceptance criteria as success criteria, reviews against the ticket, and opens a PR that closes it.
- From [mattpocock/skills](https://github.com/mattpocock/skills) at `a496f55`: `grilling`, `grill-me`, `grill-with-docs`, `domain-modeling`, `codebase-design`, `to-spec`, `to-tickets`, `triage`, `wayfinder`, `research`, `prototype`, and `code-review` as `two-axis-review`. None carries `disable-model-invocation`, so the router can call each.
- `setup-modemax` configures the machine (models, session hook) and the repo (issue tracker, triage labels, domain docs).
- `tdd` has two modes: feature mode (red → green at agreed seams) and bug mode (failing regression test first).
- Removed: `ketchup`, `ketchup-video`, `bro`, `automate-me`, `create-formal-verification-skill`, `maintain-formal-verification-skill`, and the upstream sync tooling (`tools/sync.mjs` and its tables).
