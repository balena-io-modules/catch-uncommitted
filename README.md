# Catch-Uncommitted

A simple sh script to error if you have uncommitted or unversioned files in your current directory.

This is designed to be used in your CI process, if you have some generated build output committed, to
ensure that it's up to date. Run your build, then run this script, and it'll fail if there are any
new or changed files that appear.

Checks for new files using `git`, so this won't complain about changed files that are ignored by `git`.
This depends on `git` being available in your `$PATH`.

## Get started

Install it:

```
npm install --save-dev catch-uncommitted
```

Add it to your CI script in package.json:

```
"scripts": {
    "ci": "npm run build && catch-uncommitted"
}
```

Run it:

```
npm run ci

[... your build here ...]

No unexpected changes, all good.
```

## Extra options

### --catch-no-git

When running `catch-uncommitted --catch-no-git`, the script will exit without an
error when git isn't available. This can be useful when you need to run the same
tests in different environments, where some of them do not have git available.

### --skip-node-versionbot-changes

When running `catch-uncommitted --skip-node-versionbot-changes`, the script will
skip checking the `package.json` & the `CHANGELOG.md` for changes, so that it
can work as part of the balenaCI pipeline.

### --exclude

Custom file exclusions may be set with `catch-uncommitted --exclude`. This flag
can be used in conjunction with other flags. For example, to skip checking a file
located at `my/file`, use `catch-uncommitted --exclude=my/file`. Multiple files
may be set by separating paths with a comma: `--exclude=my/file,VERSION`.
