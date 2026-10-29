# modemax

modemax shapes work with you into tickets, then builds each ticket with verified evidence and ships it as a PR that closes the ticket. It merges Lauren Tan's pstack (via the pstack-claude port) with Matt Pocock's skills, for Claude Code, Codex, Pi, GitHub Copilot, Muse, and other agent harnesses.

Tell `modemax` your goal and it picks the phase and the workflow. It grills you on the decisions that are yours (`grill-with-docs`), writes the spec and tickets (`to-spec`, `to-tickets`), builds a ticket (`implement`) with `architect`, test-first seams, and `interrogate`, and reviews the result against the ticket (`two-axis-review`).

## Install

```text
/plugin install modemax --marketplace maximechbt/skills
```

## What it contains

- Skills: Markdown instructions the agent reads. Public ones appear as `/modemax:<name>` slash commands.
- Agents: `modemax:modemax-agent` and `modemax:comment-sicko`.
- A SessionStart hook that injects the modemax routing mandate unless your `modemax-models.md` sheet turns it off.
- A Pi extension that supplies the subagent, question, and wake-up tools, `/loop`, and the same routing mandate when the repository is installed as a Pi package.
- Local scripts for watching and shipping pull requests, orchestrating multi-phase plans, and auditing worktrees.

## Data handling

modemax has no server or telemetry. Anything its skills ask your agent to read, including session transcripts, goes to your model provider. Scripts run locally, and PR tools use your GitHub CLI login.

## Links

- [Skills, slash commands, runtime setup, and model configuration](https://github.com/maximechbt/skills/blob/main/docs/reference.md)
- [Issues and support](https://github.com/maximechbt/skills/issues)
- [Security policy](https://github.com/maximechbt/skills/blob/main/SECURITY.md)

## License

MIT. Includes MIT-licensed work © 2026 Lauren Tan, © 2026 Michael Denyer, © 2026 Cursor, and © 2026 Matt Pocock. See [NOTICE.md](https://github.com/maximechbt/skills/blob/main/NOTICE.md).
