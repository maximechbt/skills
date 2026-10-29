# Prompts worth copying

Swap in the real paths, skills, and done checks. Informal wording works.

## Shape the work

- `/setup-modemax` once per repo, so tickets have somewhere to live.
- `/grill-with-docs i want <feature>. grill me until we agree, then /to-spec and /to-tickets.`
- `/wayfinder <huge, foggy goal>.` Then one decision ticket per session: `/wayfinder <map issue>`.
- `/triage what needs my attention?`
- `/implement #42` builds one ticket and opens a PR that closes it. `/implement next` takes the first unblocked ticket.

## Understand

- `/modemax read <thread>. restate the underlying issue in your own words, in plain english.`
- `/in-your-own-words <long or messy ask>`
- `/sharpen <the prompt you're about to send>`
- `/modemax investigate why <symptom>. give me what we know, what data you used, and your best hypotheses. don't change any code yet.`
- `use /how to understand <subsystem>. then use /why to find out why it broke recently.`
- `/recall my work on <topic> from last week, then read <issue>.`
- `/teach me why you implemented it this way and not <other way>. what did you trade off?`
- `/modemax take over this branch. read the decision log, find what's done, and continue. don't redo finished work.`

## Build

- Bug: `/modemax <symptom>. repro first, then fix and verify.`
- Bug in an app: `/modemax repro this with /verify. if it repros on main, fix it and show me a video as proof.`
- Bug with a cheap test: `/modemax repro <bug> first. if there's a cheap test path, /tdd it. then fix and rerun.`
- Feature: `/modemax add <behavior>. <current output> stays byte-identical. verify both.`
- Refactor: `/modemax move <code> into one module, zero behavior change. record the current output first and prove it's unchanged after.`
- Perf: `/modemax <operation> takes <time> on <fixture>. trace it, fix the measured cause, show me before and after.`

## Design and plan

- `/modemax prototype a few options for <feature>. take screenshots or videos for me to compare.`
- `/modemax we need <feature>. /architect it first, and answer open questions with prototypes. let me review before proceeding.`
- `/modemax write a tutorial for how i would use <new package> first. then /teach me why it beats the current one.`
- `ask /arena for a second opinion on this thread and our approach.`
- `/modemax turn this design into a plan. small verifiable PRs, each with its own verification steps.`
- `/modemax plan the migration of <library> to <target>. small verifiable PRs. the result must match the original exactly, bugs included.`

## Review and ship

- `/interrogate the whole branch, but skeptically. don't change anything yet. no nitpicks unless it's a real bug or regression.` Read the Dropped list too.
- `/swarm check every package under <dir> against its check script. one worker per package. one report.`
- `/modemax open the pr. small ordered commits, evidence in the description.`
- `/modemax babysit this pr. get it green.` For status only: `/modemax check on pr <number>. anything outstanding?`
- `/modemax land the stack.`

## Away and back

- `/modemax im going to bed. <goal> in a fresh worktree off <base>. done means <checks>. keep a decision log. don't ask me before committing. /loop until done. if you're truly stuck after a few hours, stop and write up why.`
- `/show-me-your-work catch me up on what you did last night.` Read its Attention section first.
- `/modemax full autopilot on this queue. each item is independent.`
- `/modemax autopilot these changes, but don't merge. i'll land them.`
- `/reflect capture what we learned so the next run doesn't repeat it.` Approve only edits that change a future decision.
