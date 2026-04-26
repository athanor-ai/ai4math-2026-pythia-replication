#!/usr/bin/env bash
# LaTeX build for the AI4MATH 2026 pythia submission.
# Same shape as the neurips-2026-anytime-valid build: pdflatex exits
# non-zero on ANY error but still produces a PDF if recoverable, so we
# don't abort on non-zero exits. We check for main.pdf at the end.
set -u

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

PDFLATEX_FLAGS="-interaction=nonstopmode"

# Tell TeX to look in styles/ for vendored ICML sty/cls/bst.
export TEXINPUTS="$DIR/styles:${TEXINPUTS:-}"
export BSTINPUTS="$DIR/styles:${BSTINPUTS:-}"

rm -f build.log

echo "[1/4] pdflatex (pass 1)..."
pdflatex $PDFLATEX_FLAGS main.tex > build.log 2>&1 || true

echo "[2/4] bibtex..."
bibtex main >> build.log 2>&1 || true

echo "[3/4] pdflatex (pass 2)..."
pdflatex $PDFLATEX_FLAGS main.tex >> build.log 2>&1 || true

echo "[4/4] pdflatex (pass 3, final)..."
pdflatex $PDFLATEX_FLAGS main.tex >> build.log 2>&1 || true

if [ ! -f main.pdf ]; then
    echo "FAIL: no main.pdf produced"
    tail -40 build.log
    exit 1
fi

# Source-hash seal so a later check can detect source edits without
# rebuild. Stored in-tree.
python3 - <<'PY'
import hashlib
from pathlib import Path
h = hashlib.sha256()
paths = [Path("main.tex")] + sorted(Path("sections").glob("*.tex"))
for p in paths:
    h.update(p.read_bytes())
Path(".pdf_source_hash").write_text(h.hexdigest() + "\n")
PY

warn_count=$(grep -c "Warning" build.log 2>/dev/null || true)
err_count=$(grep -cE "^!|^LaTeX Error" build.log 2>/dev/null || true)
echo
echo "OK: main.pdf -> $(ls -lh main.pdf | awk '{print $5, $9}')"
echo "    warnings: $warn_count    errors: $err_count (see build.log)"

# paper_lint gate. Run with the athanor-builder paper_lint tool.
# PYTHONPATH points at the local builder checkout.
if [ -z "${SKIP_PAPER_LINT:-}" ]; then
    BUILDER_PATH="${BUILDER_PATH:-$HOME/athanor-builder}"
    if [ -d "$BUILDER_PATH/tools" ]; then
        echo
        echo "[5/5] paper_lint..."
        PYTHONPATH="$BUILDER_PATH/tools" python3 -m paper_lint "$DIR" || {
            echo "FAIL: paper_lint reported issues (see above)."
            exit 2
        }
    else
        echo
        echo "WARN: paper_lint skipped (BUILDER_PATH=$BUILDER_PATH not found)."
    fi
fi
