#!/bin/sh

BASEDIR=`dirname "$0"`
BASEDIR=`(cd "$BASEDIR"; pwd)`

CUSTOM_M2_REPO=/d/repository
M2_REPO=~/.m2/repository
M2_REPO=`(cd "$M2_REPO"; pwd)`

#echo Absolute basedir: $BASEDIR - and repo: $M2_REPO

if [ -z $1 ]; then 
  TARGET_JAR="ojdbc14-10.2.0.3.0.jar"
  echo Missing parameters, please see below example and try again: 
  echo $0 ojdbc14-10.2.0.3.0.jar
  exit
else
  TARGET_JAR="$1"
fi

EXISTING_PATH=$(find "$BASEDIR" -name $TARGET_JAR -type f)
EXISTING_M2_REPO=$(find "$M2_REPO" "$CUSTOM_M2_REPO" -name $TARGET_JAR -type f)
#EXISTING_M2_REPO=/d/repository/com/sun/jmx/jmxri/1.2.1/jmxri-1.2.1.jar

if [ ! -z $EXISTING_M2_REPO ]; then
  echo Found in repo: $EXISTING_M2_REPO
  JAR_PATH=${EXISTING_M2_REPO#$M2_REPO}
  JAR_PATH=${JAR_PATH#$CUSTOM_M2_REPO}
  #echo jar path $JAR_PATH
  JAR_PATH_DIR=${JAR_PATH%$TARGET_JAR}
  #echo jar path dir $JAR_PATH_DIR
  JAR_DIRNAME=$(dirname $JAR_PATH)
  #echo jar dirname $JAR_DIRNAME

  if [ -z $EXISTING_PATH ]; then
    #echo Zero-length - empty file in expected dir $EXISTING_PATH
    mkdir -p "$BASEDIR"/release/$JAR_DIRNAME
    #echo Dirname to copy "$BASEDIR"/release/$JAR_DIRNAME
    #echo Path to copy "$BASEDIR"/release"$JAR_PATH_DIR"
    cp -rf $EXISTING_M2_REPO "$BASEDIR"/release/$JAR_DIRNAME
    EXISTING_PATH=$(find "$BASEDIR" -name $TARGET_JAR -type f)
    echo AFTER copy: $EXISTING_PATH
  fi

fi

cd "$BASEDIR"
GIT_STATUS_DIRTY=$(git status --porcelain)
if [ ! -z "$GIT_STATUS_DIRTY" ]; then
  echo -e " \n Updating git before pushing to remote! \n "
  git pull --rebase
  echo -e " \n Updating file-listing and pushing to remote! \n "
  find . -name "*.jar" -type f > file-listing.txt
  git add . && git commit -a -m "added Jar $JAR_DIRNAME $TARGET_JAR " && git push 
fi
cd -

