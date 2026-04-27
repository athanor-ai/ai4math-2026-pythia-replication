# latexmk configuration for Overleaf and any caller that respects
# latexmkrc. Prepends `./styles/` to the TEXINPUTS / BSTINPUTS search
# path so `\usepackage{icml2026}` and the matching `.bst` resolve
# without requiring the caller to set environment variables.
#
# Local builds use `build.sh`, which sets TEXINPUTS / BSTINPUTS
# directly. Overleaf and any standalone `latexmk main.tex` call use
# this file instead.

ensure_path('TEXINPUTS', './styles');
ensure_path('BSTINPUTS', './styles');

# Use pdflatex by default (matches build.sh).
$pdf_mode = 1;
