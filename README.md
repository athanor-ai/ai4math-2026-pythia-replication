# Replication package — pythia: a Lean 4 tactic library for statistical proof automation

AI4Math @ ICML 2026 submission.

## One command

```bash
bash reproduce.sh
```

Verifies the Lean library compiles axiom-clean (~5 min after Mathlib cache download).

## Requirements

- Lean 4 via [elan](https://github.com/leanprover/elan)

## What gets reproduced

| Step | Output | Paper location |
|------|--------|----------------|
| Lean axiom audit | all 32 theorems build clean | §2, §3 |

## Note

The Python simulation layer (property-based tests and parameter sweeps) is described in the paper but the scripts are not yet included in this release. The Lean library and axiom audit are the primary reproducible artifact.
