# AI4MATH 2026 submission: pythia

LaTeX source for the AI4MATH 2026 workshop submission on `pythia`, a
Lean 4 tactic library for statistical proof automation.

- Workshop CFP: <https://ai4math2026.github.io/#cfp>
- Deadline: 2026-05-25
- Format: ICML 2025 styles vendored under `styles/` (AI4MATH 2026 has
  no independent template; ICML 2026 styles not yet released as of
  build time, so we use 2025 as the closest live template).

## Build

```bash
bash build.sh
```

Runs `pdflatex` x3 + `bibtex` and produces `main.pdf`. Set
`SKIP_PAPER_LINT=1` to skip the lint gate.

## paper_lint

The build invokes the athanor-builder `paper_lint` tool to catch
em-dashes, AI-fingerprint vocabulary, semicolons-as-prose-glue, and
intent-hedging. Configure via `paper_lint.toml`. Set
`BUILDER_PATH=/path/to/athanor-builder` if your checkout is not at
`$HOME/athanor-builder`.

Manual invocation:

```bash
PYTHONPATH=$HOME/athanor-builder/tools python3 -m paper_lint .
```

## Companion repositories

- The `pythia` Lean 4 library lives at the public open-source
  repository (URL redacted for double-blind submission; supplied in
  camera-ready). The library and its CI live there.
- The `FormalAVS` benchmark and the dataset paper that reports full
  Aristotle / DSPv2 / Opus 4.6 numbers live in the companion dataset
  paper repository (URL redacted; cited as `\cite{anonymous2026formalavs}`).

## Layout

- `main.tex`: top-level driver.
- `sections/`: section-by-section content (abstract, intro,
  tactic-surface, library, aristotle, discussion, appendix).
- `references.bib`: BibTeX.
- `styles/`: vendored ICML 2025 sty/cls/bst.
- `paper_lint.toml`: lint config, `venue = "ai4math-2026"` (preset
  not yet shipped in athanor-builder; documented gap inside the
  config).
- `build.sh`: build driver.
- `figures/`: figure assets.
