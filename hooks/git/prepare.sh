#!/bin/bash

exec 1>&2

SCRIPT_ERROR=0

REPO_DIR=$(git rev-parse --show-toplevel)
DOT_GIT_DIR=$(git rev-parse --git-dir)
if [ "$DOT_GIT_DIR" = ".git" ]; then
	DOT_GIT_DIR="$REPO_DIR"/"$DOT_GIT_DIR"
fi
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
HOOKSPATH=`realpath ${DOT_GIT_DIR}/hooks`

ln -s -t $HOOKSPATH -r $SCRIPTPATH/post-commit
SCRIPT_ERROR=$(($SCRIPT_ERROR+$?))
ln -s -t $HOOKSPATH -r $SCRIPTPATH/post-merge
SCRIPT_ERROR=$(($SCRIPT_ERROR+$?))
ln -s -t $HOOKSPATH -r $SCRIPTPATH/post-checkout
SCRIPT_ERROR=$(($SCRIPT_ERROR+$?))

if [ $SCRIPT_ERROR -gt 0 ];then
    echo "Failed to link one or more files in $HOOKSPATH"
    exit 1
else
    echo "Hooks linked successfully"
fi
