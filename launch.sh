#!/bin/zsh

UNITY="/Applications/Unity/Hub/Editor/2019.4.31f1/Unity.app/Contents/MacOS/Unity"
export UNITY

# compile & initialize the project
"$UNITY" -batchmode -nographics -quit -projectPath template

while read -r name; do
  echo "$name"
  PROJECT="projects/vpai-test-$name"
  rm -rf "$PROJECT"
  cp -rf template "$PROJECT"
  sed -i '' "s/productName: vpai-test-project/productName: vpai-test-$name/" "$PROJECT/ProjectSettings/ProjectSettings.asset"

  export PROJECT
  ( "$UNITY" -projectPath "$PROJECT" & ) &
done < names.txt
