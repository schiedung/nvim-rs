#!/bin/sh

# SVN merge-tool-cmd wrapper: opens MINE and THEIRS as a diff with the merge
# target in a split below. Register it in ~/.subversion/config:
#
#   [helpers]
#   merge-tool-cmd = /path/to/svnmerger.sh
#
# SVN calls merge-tool-cmd as `base theirs mine merged wcpath`.
# BASE and WCPATH are unused here but kept for positional clarity.
THEIRS=${2}
MINE=${3}
MERGED=${4}

# Paths are quoted so filenames containing spaces survive. $MERGED is passed to
# an Ex command rather than the shell, so it is escaped with fnameescape().
nvim -d "$MINE" "$THEIRS" \
    -c ":botright split | execute 'edit ' . fnameescape('${MERGED}')" \
    -c ":diffthis" \
    -c "setl statusline=MERGED | wincmd W | setl statusline=THEIRS | wincmd W | setl statusline=MINE"
