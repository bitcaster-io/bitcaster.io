#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
SITEDIR=${BASEDIR}/bc-site

mv $BASEDIR/docs $BASEDIR/docs_obsolete 
REVERT=$?

cd $SITEDIR
hugo -d ../docs
if [ $? -eq 0 ]; then
  rm -rf ../docs_obsolete
  mv ../docs/index.html ../docs/demo.html
  cp content/demo.html ../docs/index.html
  cp ${BASEDIR}/gitinfo.js ../docs
else
  echo "failed to create site"
  if [ $REVERT != 0 ];then
    mv ../docs_obsolete ../docs
  fi
fi

cd $BASEDIR