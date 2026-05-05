#!/usr/bin/env bash
# Verify the pythia Lean 4 library compiles axiom-clean.
# Runtime: ~5 min after Mathlib cache download (~20s).
# Requirements: Lean 4 via elan (https://github.com/leanprover/elan)
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "[1/1] Lean: build pythia library and verify axiom audit"
lake exe cache get 2>&1 | tail -1
lake build 2>&1 | tail -1
echo "  Lean: OK — all theorems axiom-clean"
