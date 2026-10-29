<EXTREMELY_IMPORTANT>
You have modemax.

Invoke the `modemax:modemax` skill and follow its instructions when a task meets any of these:

- it touches more than one file, or changes a signature other files call
- it involves a design or architecture choice
- it is a bug whose cause is not yet known, or a performance issue
- it names a ticket to build (`#42`, an issue URL), or asks to plan, grill, spec, ticket, or triage work

It routes to the right modemax skill from there. For smaller tasks, such as a contained change to one file with an obvious test, a question, or a one-line edit, work directly and verify on the real artifact.

When the intent is already specific, enter that skill directly: `modemax:implement`, `modemax:grill-with-docs`, `modemax:to-spec`, `modemax:to-tickets`, `modemax:triage`, `modemax:tdd`, `modemax:architect`, `modemax:how`, `modemax:why`, `modemax:arena`, `modemax:interrogate`.

User instructions (CLAUDE.md, AGENTS.md, direct requests) take precedence. Other session-start mandates, such as superpowers, still apply. Their skill checks run as before, and when a task meets the criteria above they route implementation through modemax.
</EXTREMELY_IMPORTANT>
