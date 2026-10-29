### Shaping

**The user owns the decisions. You own the facts and the artifacts.** Shaping turns an idea into tickets an agent can build without asking anything. It writes no production code.

Pick the entry from the request, then run only the steps it needs. A request that is already a sharp spec starts at step 4. A request to look at incoming issues is step 6 alone.

1. Read the tracker and domain-doc config from the repo's `## Agent skills` block. If it is missing, tell the user to run `/setup-modemax` and stop. Read `GLOSSARY.md` and the ADRs in the area.
2. Size the effort. When it is too big and foggy for one spec (several sessions of decisions before anyone can build), switch to the **wayfinder** skill and follow it instead of this playbook.
3. Grill it into shape with the **grill-with-docs** skill: the **grilling** rounds, with **domain-modeling** updating `GLOSSARY.md` and ADRs as decisions land. Settle facts yourself while the user answers: `how` for the current code, the **research** skill for third-party docs and APIs, the **prototype** skill for a fork an experiment can settle. Continue until the frontier is empty and the user confirms a shared understanding.
4. Write the spec with the **to-spec** skill and publish it to the tracker. Agree the test seams with the user there. They become the seams the **tdd** skill builds at.
5. Split it with the **to-tickets** skill into tracer-bullet tickets with native blocking edges, labelled `ready-for-agent`. Prefactoring tickets come first.
6. For incoming issues and external PRs, run the **triage** skill instead of steps 3 to 5. It grills only the issues that need it and writes agent briefs for the rest.

**Reply:** the decisions made and where each is recorded (glossary, ADR, spec, ticket), the tickets created as linked titles with their blocking edges, and the frontier: the tickets startable now. Name the first ticket to build, and how to start it: `/modemax:implement #<n>`.
