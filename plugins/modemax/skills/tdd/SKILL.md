---
name: tdd
description: "Test-first work in two modes: build a feature red → green at agreed seams, or fix a bug by writing the failing regression test first. Use when the user asks for TDD, red-green-refactor, a failing test, or a regression test, when `implement` builds a ticket, OR when a bug has an obvious cheap local test target. Skip when the test path is unclear, expensive, integration-heavy, or not requested."
---

# TDD

Pick the mode from the task:

- **Feature mode**: building new behavior, usually a ticket from `implement`. Run the red → green loop at seams agreed before the first test.
- **Bug mode**: fixing a defect with a clear, cheap test path. Make the broken behavior executable before changing production code.

Both modes share [What a good test is](#what-a-good-test-is) and the **principle-test-behavior-not-implementation** skill. Read `GLOSSARY.md` when it exists, so test names use the project's domain language, and respect ADRs in the area you touch.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification: "user can checkout with valid cart" names a capability, and it survives refactors because it doesn't care about internal structure.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

Anti-patterns:

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks on a refactor that kept behavior.
- **Tautological**: the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`), so it passes by construction. Expected values come from an independent source of truth: a known-good literal, a worked example, the spec.
- **Horizontal slicing**: writing all tests first, then all implementation. Bulk tests verify imagined behavior. Work in vertical slices instead: one test, one implementation, repeat.

## Feature mode

### Seams: where tests go

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals.

**Test only at agreed seams.** Before writing any test, write down the seams under test. When the ticket or spec already names them (`to-spec` agrees them with the user), use those. Otherwise propose them, each with a one-line note on what it catches and what it misses, and confirm with the user when they are around. Under the **principle-never-block-on-the-human** skill, when they are not, pick the highest existing seam, say so, and proceed. Prefer existing seams to new ones, and the fewest seams that cover the ticket's acceptance criteria.

When the shape of the interface is itself in question (how deep the module is, where the seam belongs, what the interface should expose), read the **codebase-design** skill for the vocabulary.

### Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Don't anticipate future tests or add speculative features.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle. Each test is a tracer bullet that responds to what the last cycle taught you.
- **Quote the red.** Confirm each new test fails for the intended reason before writing code: quote the failure content, not the assertion line.
- **Refactoring is not part of the loop.** It belongs to review (`deslop`, `two-axis-review`), not the red → green cycle.

## Bug mode

Do not force a test when it would be impractical. If the available test would require broad harness setup, brittle mocks, slow end-to-end infrastructure, production-only state, vague reproduction steps, or large unrelated fixture churn, skip adding a new test and use the closest useful verification instead.

1. **Understand the bug.** Identify the intended behavior, current behavior, affected path, and smallest observable reproduction.
2. **Choose the narrowest executable check.** Prefer the closest unit, component, integration, or regression test already used for that codepath. If no practical test path is obvious, do not create one from scratch just to satisfy the workflow.
3. **Write the failing test first.** Add the smallest focused test that would have caught the bug. The test should encode intended behavior, not mirror the current implementation.
4. **Run the new test before fixing.** Confirm it fails for the intended reason. Quote the failure content, not the assertion line: an exception, an empty result against a literal, and the predicted mismatch all print red, and only the last one proves the test measures the bug. If it passes or fails for an unrelated reason, correct the test or reproduction before editing the implementation.
5. **Fix the bug.** Make the smallest production change that satisfies the intended behavior while preserving nearby contracts.
6. **Rerun the regression test.** Confirm the test now passes.

### If a failing test is impractical

Use the closest executable regression check instead: a targeted script, manual reproduction command, browser automation, snapshot comparison, log assertion, or focused integration check.

Prefer no new test over a bad test. A bad test is one that mostly tests mocks, encodes current implementation details, depends on timing or unrelated global state, needs expensive infrastructure for a small fix, or would be deleted immediately after proving the fix.

## Guardrails

- Do not change tests merely to match a wrong implementation.
- Do not weaken existing assertions unless the expected behavior has genuinely changed and the reason is clear.
- Keep each test focused. Avoid broad fixture churn or unrelated coverage expansion.
- If a bug is flaky, make the test deterministic where possible and document the signal being locked down.
- If a bug exposes a broader class of failures, first land the focused regression path, then consider sibling coverage.

## Final response

Report the evidence, not just the outcome:

- Name each failing-before test or executable check and quote the failure it produced, trimmed to the diff.
- Name the passing-after run and any nearby validation performed.
- In feature mode, name the seams tested and the acceptance criteria each test covers.
- If failing-before evidence could not be demonstrated, state why and describe the closest check used instead.
