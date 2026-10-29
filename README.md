# modemax

modemax is a skill suite for coding agents. It shapes work with you into tickets, then builds each ticket with verified evidence and ships it as a PR that closes the ticket.

It merges two skill suites:

- **How to build**, from Lauren Tan's pstack through the [pstack-claude](https://github.com/michael-denyer/pstack-claude) port. The `modemax` router picks a playbook for the task, delegates code to subagents, and verifies on the real artifact. Diffs stay small, prose has no AI tells, and the agent does not stop to ask what it can find out itself.
- **How to shape work**, from [mattpocock/skills](https://github.com/mattpocock/skills). Grilling sessions settle the decisions, `GLOSSARY.md` and ADRs keep the domain language, and specs and tracer-bullet tickets go to GitHub Issues with native blocking edges.

The ticket is the contract between the two halves:

```text
Shape (with you)            Build (autonomous)               Ship
grill-with-docs             implement #42                    PR with "Closes #42"
  -> to-spec                  -> how -> architect             -> two-axis-review
  -> to-tickets               -> tdd at the agreed seams      -> babysit, shipping
     ready-for-agent          -> verify each acceptance       -> next unblocked ticket
                                 criterion
```

## Install

<details>
<summary><strong>Claude Code</strong></summary>

Run in Claude Code 2.1.292 or later:

```text
/plugin marketplace add maximechbt/skills
/plugin install modemax@modemax
```

Claude Code leaves auto-update off for third-party marketplaces, so modemax stays on the version you installed. To turn it on, run `/plugin`, open the **Marketplaces** tab, select `modemax`, and choose **Enable auto-update**. To update once by hand, run `claude plugin update modemax@modemax`.

</details>

<a id="codex"></a>
<details>
<summary><strong>Codex</strong></summary>

Run in your terminal:

```shell
codex plugin marketplace add maximechbt/skills
codex plugin add modemax@modemax
```

</details>

<details>
<summary><strong>Pi</strong></summary>

Run in your terminal:

```shell
pi install git:github.com/maximechbt/skills
```

The package loads the skills and the modemax Pi extension, which adds the subagent, question, and wake-up tools the skills use, plus `/loop` and the routing instruction. Invoke a skill with `/skill:<name>`.

</details>

<details>
<summary><strong>GitHub Copilot</strong></summary>

Run in your terminal:

```shell
copilot plugin marketplace add maximechbt/skills
copilot plugin install modemax@modemax
```

This installs modemax for the Copilot CLI and the GitHub Copilot app, which share `~/.copilot`. Start a new session afterwards. Copilot ships no default modemax models, so the first skill that needs one runs `setup-modemax` to pick from the models your account lists, and later sessions reuse that choice.

The Copilot build is tested on Copilot CLI 1.0.87 through 1.0.92. On those versions the routing hook's context reaches the session alongside other plugins' session-start context. If a later version keeps only one plugin's context, `setup-modemax` offers a [standing instruction](plugins/modemax/skills/setup-modemax/copilot.md#wire-it-in) for `~/.copilot/copilot-instructions.md` instead. On 1.0.92, once the CLI caches its computer-use experiment assignment, `copilot -p` sessions list no plugin skills and a `skill` call returns "Skill not found". Interactive sessions, the hooks, and the agents are unaffected.

</details>

<details>
<summary><strong>Muse</strong></summary>

Run in your terminal:

```shell
git clone https://github.com/maximechbt/skills
cd skills
muse plugins install ./plugins/modemax
muse plugins approve modemax
```

The first command installs the native Muse plugin bundle. The second approves its `SessionStart` hook and agent definitions, which Muse runs only after approval. Start a new session afterwards. Invoke a skill with `/<name>` (for example `/modemax`), which Muse lists for each user-invocable skill.

</details>

<a id="other-harnesses"></a>
<details>
<summary><strong>Other harnesses</strong></summary>

OpenCode (the CLI and the desktop app), Gemini CLI, Prime Agent, and skills-only Codex installs read skills from `~/.agents/skills/`. Run in your terminal:

```shell
git clone https://github.com/maximechbt/skills
cd skills
mkdir -p ~/.agents/skills
for s in plugins/modemax/skills/*/; do
  target=~/.agents/skills/"$(basename "$s")"
  test -e "$target" || test -L "$target" || ln -s "$(pwd)/$s" "$target"
done
```

To update, run `git pull` in the clone, then run the `for` loop again to link skills added since the last run. These installs have no routing hook, so ask for `modemax` by name or add a standing instruction to the harness's instruction file. See [shared installation](docs/reference.md#shared-skills-installation) for per-harness notes and uninstalling.

</details>

### Configure

modemax routes tasks to `modemax` automatically. At session start, a hook injects an instruction that points the agent at it: the plugin's hook on Claude Code, Codex, GitHub Copilot, and Muse, and the modemax extension on Pi. Codex runs the hook only after you trust it through `/hooks`, and Muse only after `muse plugins approve modemax`. Other harnesses have no hook.

Run `setup-modemax` to turn automatic routing on or off, change model defaults, or set a reasoning effort per role (`arena runners: opus @xhigh, fable @max`).

## Getting started

Set modemax up once per machine and once per repo:

```text
/modemax:setup-modemax
```

It picks a model for each role and sets up the repo's issue tracker, triage labels, and domain docs.

Shape a feature with the user:

```text
/modemax:grill-with-docs I want users to export their invoices as CSV.
```

The agent asks rounds of numbered questions, each with its recommended answer, and records terms and decisions as they land. Then `/modemax:to-spec` publishes the spec and `/modemax:to-tickets` splits it into tickets labelled `ready-for-agent`.

Build a ticket:

```text
/modemax:implement #42
```

The agent reads the ticket, claims it, runs the Feature, Bug fix, or Refactoring playbook with the ticket's acceptance criteria as success criteria, reviews the diff against the ticket, and opens a PR that closes it. `/modemax:implement next` takes the first ticket whose blockers are closed.

For anything else, describe the goal. The session hook routes non-trivial work to `modemax`, which picks the phase and the playbook.

## Details

- [Skills and slash commands](docs/reference.md#slash-commands)
- [Runtime setup](docs/reference.md#runtime-support)
- [Models and dependencies](docs/reference.md#configuration-and-dependencies)
- [Maintenance and sources](docs/reference.md#maintenance)

## Data handling

modemax has no server or telemetry. Anything its skills ask your agent to read, including session transcripts, goes to your model provider. Scripts run locally, and PR tools use your GitHub CLI login.

## License

modemax is [MIT-licensed](LICENSE). It includes MIT-licensed work by Lauren Tan, Michael Denyer, Cursor, and Matt Pocock. [NOTICE.md](NOTICE.md) records the source and license of each part.
