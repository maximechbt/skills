#!/bin/sh
# GitHub Copilot only. pre-tool-use.awk decides the call: it approves `view` of
# this plugin's own files and the strict form of a vendored script run, and it
# denies a modemax agent dispatch on a model the user did not save. Anything else
# gets no output and takes the normal permission flow.
# Copilot denies the call when this hook exits non-zero, so every path exits 0.
# A failed awk run prints its error to stderr, and its output is dropped.
out=$(LC_ALL=C MODEMAX_ROOT="${COPILOT_PLUGIN_ROOT%/}" MODEMAX_REAL_ROOT="$(cd "$COPILOT_PLUGIN_ROOT" && pwd -P)" \
  MODEMAX_SHEET="${COPILOT_HOME:-$HOME/.copilot}/modemax-models.md" \
  MODEMAX_SHEET_READER="${COPILOT_PLUGIN_ROOT}/skills/setup-modemax/scripts/read-sheet.sh" \
  awk -f "${COPILOT_PLUGIN_ROOT}/hooks/json.awk" \
  -f "${COPILOT_PLUGIN_ROOT}/skills/setup-modemax/scripts/sheet.awk" \
  -f "${COPILOT_PLUGIN_ROOT}/hooks/script-contracts.awk" \
  -f "${COPILOT_PLUGIN_ROOT}/hooks/pre-tool-use.awk") || out=
[ -z "$out" ] || printf '%s\n' "$out"
exit 0
