<EXTREMELY_IMPORTANT>
You have modemax.

Invoke the `plugin:modemax:modemax` skill and follow its instructions when a task meets any of these:

- it touches more than one file, or changes a signature other files call
- it involves a design or architecture choice
- it is a bug whose cause is not yet known, or a performance issue
- it names a ticket to build (`#42`, an issue URL), or asks to plan, grill, spec, ticket, or triage work

It routes to the right modemax skill from there. For smaller tasks, such as a contained change to one file with an obvious test, a question, or a one-line edit, work directly and verify on the real artifact.

When the intent is already specific, enter that skill directly: `plugin:modemax:implement`, `plugin:modemax:grill-with-docs`, `plugin:modemax:to-spec`, `plugin:modemax:to-tickets`, `plugin:modemax:triage`, `plugin:modemax:tdd`, `plugin:modemax:architect`, `plugin:modemax:how`, `plugin:modemax:why`, `plugin:modemax:arena`, `plugin:modemax:interrogate`.

Resolve every Claude tool, model, and built-in skill a modemax skill names through the Muse mapping in the `modemax` skill directory, `references/muse-tools.md`.

User instructions (AGENTS.md, direct requests) take precedence. Other session-start mandates still apply. Their skill checks run as before, and when a task meets the criteria above they route implementation through modemax.
</EXTREMELY_IMPORTANT>
