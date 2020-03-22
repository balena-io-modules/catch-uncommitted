#!/bin/bash
set -e

catch_no_git=0
ignore_eol=''
extra_args=()

while [ $# -gt 0 ]; do
	key=$1
	shift
	case $key in
		--catch-no-git)
			catch_no_git=1
		;;
		--skip-node-versionbot-changes)
			paths=("package.json" "package-lock.json" "npm-shrinkwrap.json" "CHANGELOG.md" ".versionbot/CHANGELOG.yml")
			for path in "${paths[@]}"; do
				extra_args+=(":(exclude)${path}")
			done
		;;
		--ignore-space-at-eol)
			ignore_eol="--ignore-space-at-eol"
		;;
		--exclude=*)
			while IFS=',' read -ra paths; do
				for path in "${paths[@]}"; do
					extra_args+=(":(exclude)${path}")
				done
			done <<< "${key#--exclude=}"
		;;
	esac
done

echo

if [ $catch_no_git -eq 1 ] && !(hash git 2> /dev/null); then
	echo "git not found, not running catch-uncommitted check"
	exit 0
elif ! git diff HEAD --exit-code ${ignore_eol} -- . "${extra_args[@]}" ; then
	echo '** Uncommitted changes found (^^^ diff above ^^^) - FAIL **'
	exit 1
fi

files="$(git ls-files --exclude-standard --others)"
if test -n "$files" ; then
	echo "$files"
	echo '** Untracked uncommitted files found (^^^ listed above ^^^) - FAIL **'
	exit 2
else
	echo 'No unexpected changes, all good.'
fi
