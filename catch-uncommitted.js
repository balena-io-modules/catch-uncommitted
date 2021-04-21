#!/usr/bin/env node
const { execFileSync } = require('child_process')
const path = require('path')

const argv = process.argv.slice(2)

try {
  execFileSync(path.join(__dirname, 'catch-uncommitted.sh'), argv, {
    stdio: 'inherit',
  })
} catch (error) {
  process.exitCode = error.status
}
