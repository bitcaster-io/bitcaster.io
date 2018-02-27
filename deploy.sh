#!/usr/bin/env bash
set -o errexit #abort if any command fails
BASEDIR=$(dirname "$0")

scp -r -P 12222 $BASEDIR/docs/* bitcaster@62.30.203.125:/htdocs/bc-site