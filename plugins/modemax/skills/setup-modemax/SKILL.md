---
name: setup-modemax
description: Set modemax up on this machine (per-role models, the SessionStart hook) and in this repo (issue tracker, triage labels, domain docs). Use for /setup-modemax, "configure modemax", changing modemax's model choices, turning the SessionStart hook on or off, or when a skill says the issue tracker or triage labels were not provided.
---

# Setup modemax

On Codex, read the [platform mapping](../modemax/references/codex-tools.md), including its per-skill notes, before following this skill.

On GitHub Copilot, read the [platform mapping](../modemax/references/copilot-tools.md), including its per-skill notes, before following this skill.

On Muse, read the [platform mapping](../modemax/references/muse-tools.md), including its per-skill notes, before following this skill.

On GitHub Copilot, follow [the Copilot setup](copilot.md) in place of steps 1, 3, 4, and 7 and step 6's header.

On another runtime, read [Other runtimes](#other-runtimes) below for where the sheet lives and how it loads; the steps are the same.

modemax needs two kinds of setup, at two scopes:

- **Part A, this machine:** the per-role model sheet and the SessionStart hook. Done once per runtime. Steps 1 to 9 below.
- **Part B, this repo:** where tickets live, the triage label vocabulary, and the domain-doc layout. Done once per repo. [Part B](#part-b-this-repo) below. The shaping skills (`to-spec`, `to-tickets`, `triage`, `wayfinder`, `two-axis-review`, `implement`) read what it writes.

Run what the user asked for. With no specific ask, check both: Part A is done when the current runtime's sheet exists, Part B when the repo's `CLAUDE.md` or `AGENTS.md` carries an `## Agent skills` block. Run each part that is not done, Part B first when a skill sent the user here for a missing tracker.

## Part A: this machine

Write the current runtime's per-role model override sheet, using the path in [Other runtimes](#other-runtimes). Each modemax skill names a default model inline; the override sheet adapts those defaults to the models you actually have access to.

Claude Code has no auto-applied "rules" mechanism like Cursor's `.mdc`. The Claude Code config directory is `$CLAUDE_CONFIG_DIR` when that variable is set and `~/.claude` otherwise. This skill calls it `<config>`. Inclusion is explicit: the user adds a line to `<config>/CLAUDE.md` (or their project `CLAUDE.md`) such as:

```text
@<config>/modemax-models.md
```

with `<config>` written as the resolved path, so the file is loaded as context for every session.

The Codex home directory is `$CODEX_HOME` when that variable is set and `~/.codex` otherwise. This skill calls it `<codex-home>`.

### 1. Detect available models

Enumerate the model names the `Agent` tool's `model` parameter accepts in this session. That is the dependable source. On Claude Code they are the family names listed in [Models](#models) below, each running that family's current model, and a full model ID is rejected. The default panel is listed there too. The panel is chosen for cross-family diversity. Ask the user to confirm or paste any additional slugs they want available. Never write a real slug you have not confirmed is available. The aliases `inherit-parent` and `auto` are always valid even though they are not detected slugs. Both mean the role runs on the parent session's model, which the `Agent` call expresses by omitting `model`.

### 2. Load current state

The default role-to-model mapping is the rule shape shown in the Write the override sheet step below. If the current runtime's sheet already exists, read it and treat its values as the current choices. Otherwise start from those defaults. A line whose role is not in that shape, such as `how critics`, is from a retired role. Drop it. An older sheet may name full model IDs that start with `claude-`, which the `Agent` tool rejects. Replace each with its family name, the word after `claude-`.

### 3. Map and confirm

Show every role with its current model, marking any real slug not in the detected set as needing a choice. Also list each line step 2 dropped or rewrote. Ask whether to accept as-is or change specific roles, offering the detected models plus `inherit-parent` and `auto` as the options. Prefer `AskUserQuestion` over free text. For panel roles (arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena runs one judge. It tries only values from a family other than the parent's, in list order, so order it by preference. An `inherit-parent` or `auto` value never judges. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

Then ask for the default reasoning effort, the `default effort` line. It is `session`, which keeps the parent session's effort, or one of the levels in [Models](#models). Start from the default listed there. Every role value without a suffix runs at it. Then ask whether any role should run at another level. On Claude Code a role value may carry one after its slug, as in `<slug> @xhigh`; panel entries take their own, as in `<slug> @xhigh, <slug> @max`. Each level is passed as the dispatch's effort, so the choice holds without changing the session. Leave the suffix off for the default effort.

### 4. Choose whether the session hook routes tasks

On Claude Code and Codex, the plugin's `SessionStart` hook injects the modemax mandate on startup, resume, clear, and compact. Codex asks the user to trust plugin hooks through `/hooks` before running them. On Pi, the modemax extension adds the same mandate to the system prompt at every agent start. On Muse, the native plugin's `SessionStart` hook injects the mandate once the user approves the plugin's hooks with `muse plugins approve modemax`. Ask whether to keep the hook. The default is on. The answer is the `session hook` line in the current runtime's sheet: `on` or `off`. With no sheet or no line, the hook injects. The line is inert on other runtimes.

### 5. Validate

Every real slug written must be in the detected set. `inherit-parent` and `auto` always pass. Validate the slug without any `@<level>` suffix, and the level against the effort levels in [Models](#models). The `default effort` value is one of those levels or `session`. On Codex, the levels are the `reasoning_effort` values your Codex models accept instead. If a chosen real slug or level is not available, stop and ask again.

### 6. Write the override sheet

Write the current runtime's sheet with the shape below. Overwrite the whole file so re-runs stay idempotent.

```markdown
# modemax model configuration

Per-role model overrides for modemax skills. Each modemax SKILL.md names its defaults in a Models section; the values here override those defaults. Delete a line to fall back to the skill default. A value of `inherit-parent` or `auto` runs that role on the parent session's model (the `Agent` call omits `model`); an alias entry in a panel list still counts toward that panel's fan-out. A model may carry a reasoning effort, as in `opus @xhigh` (levels: low, medium, high, xhigh, max); the role's subagent then runs at that level, each entry of a panel list on its own. `default effort` sets the level for a value without one; `session` keeps the parent session's effort. `session hook: off` stops the Claude Code, Codex, or Muse SessionStart hook, or the modemax Pi extension, from injecting the modemax mandate; any other value, or no line, leaves it on.

feature, refactoring: sonnet
bug-fix: opus
perf-issue: opus
hillclimb: opus
judgment and prose: opus
strongest judgment: fable
how explorer: opus
how explainer: opus
why investigators: opus
why synthesizer: opus
reflect tooling: opus
reflect judgment, divergent, synthesizer: opus
arena runners: opus, fable, sonnet, haiku
arena cross-judge pool: opus, fable, sonnet, haiku
swarm workers: opus
architect runners: opus, fable, sonnet, haiku
interrogate reviewers: opus, fable, sonnet, haiku

default effort: session
session hook: on
```

### 7. Wire it in

On Claude Code, if `<config>/CLAUDE.md` does not already include `<config>/modemax-models.md`, append an `@` line naming the sheet's resolved path, such as `@~/.claude/modemax-models.md`, so the model rows load on every session. If the user prefers project scope, add the include to the project's `CLAUDE.md` instead.

On Codex, paste the model rows and the `default effort` line into `<codex-home>/AGENTS.md`; Codex has no `@` include. Do not paste the `session hook` line there: the plugin hook reads it directly from `<codex-home>/modemax-models.md`.

On Muse, no include line is needed: the plugin hook reads the sheet directly and injects its role lines at session start. It runs only after the user approves the plugin's hooks, so name `muse plugins approve modemax` when the hook has not run yet.

### 8. Confirm

Tell the user where the override was written, how its model rows load, and whether the plugin hook is on. Re-running this skill updates the override sheet.

### 9. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a project `verify` or `verify-*` skill, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with /create-verification-skill." On yes, invoke [`/create-verification-skill`](../create-verification-skill/SKILL.md). On no, move on without pushing.

## Part B: this repo

Scaffold the per-repo configuration the shaping skills assume. This part is prompt-driven, not a script: explore, present what you found, confirm with the user, then write.

### B1. Explore

Read whatever exists; don't assume:

- `git remote -v`: is this a GitHub or GitLab repo, and which one?
- `CLAUDE.md` and `AGENTS.md` at the repo root: does either exist, and does either already carry an `## Agent skills` block?
- `GLOSSARY.md` or `GLOSSARY-MAP.md` at the root, `docs/adr/`, and any `src/*/docs/adr/`.
- `docs/agents/`: this part's earlier output.
- `.scratch/`: a sign that local-markdown tickets are already in use.
- Monorepo signals: `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, or a populated `packages/*` with its own `src/`. Their absence means a single context, which is almost every repo.

### B2. Ask, one section at a time

Lead each section with the recommended answer so the user can accept it in a word. Skip a section the exploration already settled.

**Issue tracker.** Where tickets live. `to-spec`, `to-tickets`, `triage`, `wayfinder`, `two-axis-review`, and `implement` read from and write to it. Propose GitHub when a remote points at GitHub, GitLab when one points at GitLab. Otherwise offer:

- **GitHub**: the repo's GitHub Issues, through `gh`.
- **GitLab**: the repo's GitLab Issues, through [`glab`](https://gitlab.com/gitlab-org/cli).
- **Local markdown**: files under `.scratch/<feature>/`, for solo work or a repo with no remote.
- **Other** (Jira, Linear, and the like): ask for a one-paragraph description of the workflow and record it as prose.

A GitHub or GitLab tracker needs a reachable repo. When no remote points at the chosen host, get the URL from the user and wire it (`git remote add origin <url>`). This step is done when `gh repo view` or `glab repo view` prints the project from inside the repo. If it cannot, stop and say what is missing.

**Triage labels.** Ask one question: keep the default labels? The recommended answer is yes. The defaults are the five canonical state roles, each label equal to its name: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. Only when the user says no, usually because the tracker already uses other names, collect the overrides so `triage` applies existing labels instead of creating duplicates.

**Domain docs.** Default to a single context (one `GLOSSARY.md` and `docs/adr/` at the root) and write it without asking. Offer multiple contexts (a root `GLOSSARY-MAP.md` pointing at per-context `GLOSSARY.md` files) only when exploration found monorepo signals.

### B3. Confirm, then write

Show the user a draft of the `## Agent skills` block and of each file under `docs/agents/`, and let them edit before you write.

Edit `CLAUDE.md` when it exists, else `AGENTS.md`. When neither exists, ask which to create. Never create one when the other already exists. When the chosen file already has an `## Agent skills` block, update it in place and leave the surrounding sections alone.

```markdown
## Agent skills

### Issue tracker

[one-line summary of where tickets live]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[single-context or multi-context]. See `docs/agents/domain.md`.
```

Write the docs from the seed templates beside this skill:

- [tracker/issue-tracker-github.md](tracker/issue-tracker-github.md), [tracker/issue-tracker-gitlab.md](tracker/issue-tracker-gitlab.md), or [tracker/issue-tracker-local.md](tracker/issue-tracker-local.md) to `docs/agents/issue-tracker.md`. For another tracker, write that file from the user's description.
- [tracker/triage-labels.md](tracker/triage-labels.md) to `docs/agents/triage-labels.md`.
- [tracker/domain.md](tracker/domain.md) to `docs/agents/domain.md`.

On GitHub or GitLab, create each configured label the tracker lacks (`gh label create` or `glab label create`).

### B4. Done

Tell the user which skills now read these files. They can edit `docs/agents/*.md` directly later. Rerunning Part B is only needed to switch trackers or start over.

## Other runtimes

The role lines are the same everywhere. What differs is the sheet path, how the runtime loads it, and how you list models. Detect models with the runtime's own tool and never write a slug you have not seen listed. A runtime whose subagent call has no model parameter still gets the sheet, as the record of the user's choice, and applies it where it can. The `session hook` line applies to the Claude Code, Codex, and GitHub Copilot plugins and to the modemax Pi extension.

| Runtime | Sheet | Load | List models | Status |
| --- | --- | --- | --- | --- |
| Claude Code | `<config>/modemax-models.md` | `@<config>/modemax-models.md` in `<config>/CLAUDE.md` | the `Agent` tool's model parameter | verified live |
| Codex | `<codex-home>/modemax-models.md` | model rows: paste into `<codex-home>/AGENTS.md`; hook setting: read by the plugin | your configured Codex models, see [codex-tools.md](../modemax/references/codex-tools.md#model-names) | hook contract tested; discovery verified |
| Pi | `modemax-models.md` in the Pi agent directory, `$PI_CODING_AGENT_DIR` or `~/.pi/agent` | read by the modemax Pi extension, model rows and hook setting both; no include line | `pi --list-models`, see [pi-tools.md](../modemax/references/pi-tools.md#model-names) and its `setup-modemax` note | extension contract tested offline; live results in the repository's `docs/pi-equivalence.md` |
| GitHub Copilot (CLI and app) | `${COPILOT_HOME:-~/.copilot}/modemax-models.md` | the plugin hook checks it and injects its role lines at session start; skills-only installs read it with `view` | the `task` tool's `model` enum, see [copilot-tools.md](../modemax/references/copilot-tools.md#model-names) | hook contract tested; CLI install smoke-tested |
| Muse | `${XDG_CONFIG_HOME:-~/.config}/muse/modemax-models.md` | the plugin hook reads it and injects its role lines at session start, once hooks are approved; no include line | the model catalog (`muse model-profile show <model>` names each one), see [muse-tools.md](../modemax/references/muse-tools.md#model-names) | hook contract tested; plugin install verified |
| opencode | `~/.config/opencode/modemax-models.md` | add the path to the `instructions` array in `opencode.json` | the `models` slash command in the session | from published docs, no live session |
| Gemini CLI | `~/.gemini/modemax-models.md` | `@~/.gemini/modemax-models.md` in `~/.gemini/GEMINI.md` | the `model` slash command in the session | from published docs, no live session |
| Prime Agent | no documented sheet path; Prime's configuration chooses models | | | no live session |

## Models

Stamped from `plugins/modemax/models.json` (edit there, rerun `tools/generate.mjs`).

- Available Claude models: `opus`, `fable`, `sonnet`, `haiku`
- Default panel: `opus`, `fable`, `sonnet`, `haiku`
- Reasoning effort levels: `low`, `medium`, `high`, `xhigh`, `max`
- Default reasoning effort: `session`
- Single-role default: `opus`
