# NOTICE

modemax combines MIT-licensed work from the sources below. All upstream copyright notices and license terms are preserved. modemax's own modifications and additions are (c) 2026 Maxime Chabert, also under the [MIT license](LICENSE).

## Upstream sources

| Component | Upstream | Copyright | License | License file |
| --- | --- | --- | --- | --- |
| The repository base: tooling, tests, runtime packaging, hooks, the Pi extension, and every skill under `plugins/modemax/skills/` not listed in the rows below | [michael-denyer/pstack-claude @ 190fc9a](https://github.com/michael-denyer/pstack-claude/tree/190fc9a009491cbcfc04e25ef5b3c2d1fcf5ca8a), a port of Lauren Tan's pstack. Its [NOTICE](https://github.com/michael-denyer/pstack-claude/blob/190fc9a009491cbcfc04e25ef5b3c2d1fcf5ca8a/NOTICE.md) records the per-skill provenance from [cursor/plugins](https://github.com/cursor/plugins) | (c) 2026 Lauren Tan, (c) 2026 Michael Denyer | MIT | [LICENSE](LICENSE) |
| `deslop`, `make-pr-easy-to-review`, `fix-ci`, `fix-merge-conflicts`, `get-pr-comments`, `what-did-i-get-done` | [cursor/plugins/cursor-team-kit](https://github.com/cursor/plugins/tree/e46364b8be46000b7df0f260550cd712afbb8d36/cursor-team-kit), through pstack-claude | (c) 2026 Cursor | MIT | [LICENSE-cursor-team-kit](LICENSE-cursor-team-kit) |
| `thermos`, `thermo-nuclear-review`, `thermo-nuclear-code-quality-review`, and their two subagent definitions | [cursor/plugins/thermos](https://github.com/cursor/plugins/tree/118e73b0e196e4d49d5aade7ce6dd8985a621f68/thermos), through pstack-claude | (c) 2026 Cursor | MIT | [LICENSE-thermos](LICENSE-thermos) |
| `grilling`, `grill-me`, `grill-with-docs`, `domain-modeling`, `codebase-design`, `to-spec`, `to-tickets`, `triage`, `wayfinder`, `research`, `prototype`, `two-axis-review` (upstream `code-review`), `setup-modemax/tracker/`, and `tdd/tests.md`, `tdd/mocking.md` | [mattpocock/skills @ a496f55](https://github.com/mattpocock/skills/tree/a496f5513d4a4cf889bc48e189e579f4b0bdf6aa) | (c) 2026 Matt Pocock | MIT | [LICENSE-mattpocock](LICENSE-mattpocock) |

## What modemax changed

[CHANGES.md](CHANGES.md) lists the changes from each source, starting with 0.1.0.
