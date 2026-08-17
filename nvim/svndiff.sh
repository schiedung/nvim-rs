#!/bin/sh

# SVN diff-cmd wrapper: opens the two revisions side by side in Neovim.
# Register it in ~/.subversion/config:
#
#   [helpers]
#   diff-cmd = /path/to/svndiff.sh
#
# Configure your favorite diff program here. Left unquoted where it is invoked
# below, because it carries both the command and its argument.
DIFF="nvim -d"

# Subversion provides the paths we need as the sixth and seventh parameters:
# it calls diff-cmd as `-u -L label1 -L label2 file1 file2`. These positions
# shift if you set `diff-extensions` in ~/.subversion/config.
LEFT=${6}
RIGHT=${7}

# $DIFF stays unquoted so it word-splits into command + flag; the paths are
# quoted so filenames containing spaces survive.
$DIFF "$LEFT" "$RIGHT"

# NOTE: the SVN docs describe a 0 = "no differences" / 1 = "differences found"
# convention for diff-cmd, but this wrapper is an interactive viewer and does not
# detect differences, so it simply returns Neovim's exit status. Verified against
# svn 1.14.1 that `svn diff` exits 0 regardless of what this script returns, so
# the distinction has no practical effect here.
