#!/bin/sh
set -e

echo

if ! git diff HEAD --exit-code ; then
	echo '** Uncommitted changes found (^^^ diff above ^^^) - FAIL **'
	exit 1
elif test -n "$(git ls-files --exclude-standard --others | tee /dev/tty)" ; then
	echo '** Untracked uncommitted files found (^^^ listed above ^^^) - FAIL **'
	exit 2
else
	echo 'No unexpected changes, all good.'
fi
