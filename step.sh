#!/bin/bash

function printAndExecuteCommand {
  echo "$ $1"
  $1
}

function printEnvVar {
  envvar_key="$"
  envvar_key+="$1"
  envvar_value=$(eval echo $envvar_key)
  echo "$ ENV: $envvar_key=$envvar_value"
}

echo "--- OSX Information ---"
echo "-----------------------"
printAndExecuteCommand "sw_vers -productVersion"
printAndExecuteCommand "system_profiler SPSoftwareDataType"

echo
echo "-------------------------"
echo "--- Xcode Information ---"
printAndExecuteCommand "xcodebuild -version"

echo
echo "-------------------------"
echo "--- Tools Information ---"
printAndExecuteCommand "brew --version"
printAndExecuteCommand "which brew"
printAndExecuteCommand "brew list"
echo
printAndExecuteCommand "xctool --version"
printAndExecuteCommand "which xctool"
echo
printAndExecuteCommand "git --version"
printAndExecuteCommand "which git"
echo
printAndExecuteCommand "wget --version"
printAndExecuteCommand "which wget"
echo
printAndExecuteCommand "npm --version"
printAndExecuteCommand "node --version"
printAndExecuteCommand "which node"

echo
printAndExecuteCommand "ruby --version"
printAndExecuteCommand "which ruby"
echo
printAndExecuteCommand "pod --version"
printAndExecuteCommand "which pod"
echo
printAndExecuteCommand "python --version"
printAndExecuteCommand "which python"

echo
echo "------------"
echo "--- User ---"
printEnvVar "HOME"
printAndExecuteCommand "whoami"

echo
echo "-------------------"
echo "--- Environment ---"
printAndExecuteCommand "env"

