#!/bin/bash

formatted_output_file_path="$BITRISE_STEP_FORMATTED_OUTPUT_FILE_PATH"

function printAndExecuteCommand {
  echo "$ $1"
  $1
}

function print_and_do_commands {
  echo "$ $@"
  $@
}

function printEnvVar {
  envvar_key="$"
  envvar_key+="$1"
  envvar_value=$(eval echo $envvar_key)
  echo "$ ENV: $envvar_key=$envvar_value"
}

function echo_string_to_formatted_output {
  echo "$1" >> $formatted_output_file_path
}

function write_section_to_formatted_output {
  echo '' >> $formatted_output_file_path
  echo "$1" >> $formatted_output_file_path
  echo '' >> $formatted_output_file_path
}

function execute_to_formatted_output {
  $1 >> $formatted_output_file_path 
}

function execute_as_code_to_formatted_output {
  formatted_code_output=$($1 | awk '{print "    " $0}')
  echo "$formatted_code_output" >> $formatted_output_file_path 
}

function execute_with_note_to_formatted_output {
  printf '%s' "$1" >> $formatted_output_file_path
  cmd_res=$(eval "$2")
  echo "$cmd_res" >> $formatted_output_file_path
}

echo "--- OS X Information ---"
echo "-----------------------"
printAndExecuteCommand "sw_vers -productVersion"
printAndExecuteCommand "sw_vers"
printAndExecuteCommand "system_profiler SPSoftwareDataType"
#
write_section_to_formatted_output '# OS X Information'
execute_to_formatted_output 'sw_vers -productVersion'
echo_string_to_formatted_output ''
execute_as_code_to_formatted_output 'sw_vers'
echo_string_to_formatted_output ''
execute_to_formatted_output 'system_profiler SPSoftwareDataType'

echo "--- Other System Information ---"
printAndExecuteCommand "df -lh"
#
write_section_to_formatted_output '# Other System Information'
write_section_to_formatted_output '## HDD'
execute_as_code_to_formatted_output 'df -lh'
echo "--------------------------------"

echo
echo "-------------------------"
echo "--- Xcode Information ---"
printAndExecuteCommand "xcodebuild -version"
printAndExecuteCommand "xcodebuild -showsdks"
#
write_section_to_formatted_output '# Xcode Information'
write_section_to_formatted_output '## Xcode Version'
execute_as_code_to_formatted_output 'xcodebuild -version'
write_section_to_formatted_output '## Xcode SDKs'
execute_as_code_to_formatted_output 'xcodebuild -showsdks'

echo
echo "-------------------------"
echo "--- Tools Information ---"
write_section_to_formatted_output '# Tools Information'
printAndExecuteCommand "brew --version"
execute_with_note_to_formatted_output '- **Brew Version**: ' 'brew --version'
printAndExecuteCommand "which brew"
printAndExecuteCommand "brew list"
echo
printAndExecuteCommand "xctool --version"
execute_with_note_to_formatted_output '- **xctool Version**: ' 'xctool --version'
printAndExecuteCommand "which xctool"
echo
printAndExecuteCommand "git --version"
execute_with_note_to_formatted_output '- **git Version**: ' 'git --version'
printAndExecuteCommand "which git"
echo
printAndExecuteCommand "hg --version"
execute_with_note_to_formatted_output '- **Mercurial/hg Version**: ' 'hg --version'
# hg has a multi-line version output
execute_to_formatted_output 'echo'
printAndExecuteCommand "which hg"
echo
printAndExecuteCommand "wget --version"
printAndExecuteCommand "which wget"
echo
printAndExecuteCommand "npm --version"
execute_with_note_to_formatted_output '- **NPM Version**: ' 'npm --version'
printAndExecuteCommand "node --version"
execute_with_note_to_formatted_output '- **NodeJS Version**: ' 'node --version'
printAndExecuteCommand "which node"

echo
printAndExecuteCommand "python --version"
execute_with_note_to_formatted_output '- **Python Version**: ' 'python --version 2>&1'
printAndExecuteCommand "which python"
echo
printAndExecuteCommand "rvm --version"
execute_with_note_to_formatted_output '- **RVM Version**: ' 'rvm --version'
printAndExecuteCommand "which rvm"
printAndExecuteCommand "rvm list"
echo
printAndExecuteCommand "ruby --version"
execute_with_note_to_formatted_output '- **Ruby Version**: ' 'ruby --version'
printAndExecuteCommand "which ruby"
echo
printAndExecuteCommand "pod --version"
execute_with_note_to_formatted_output '- **Cocoapods Version**: ' 'pod --version'
printAndExecuteCommand "which pod"

echo
printAndExecuteCommand "go version"
execute_with_note_to_formatted_output '- **Go: Version**: ' 'go version'
print_and_do_commands echo "GOPATH: $GOPATH"
execute_with_note_to_formatted_output '- **Go: GOPATH**: ' "echo $GOPATH"
printAndExecuteCommand "which pod"

echo
echo "------------"
echo "--- User ---"
printEnvVar "HOME"
printAndExecuteCommand "whoami"

echo
echo "-------------------"
echo "--- Environment ---"
printAndExecuteCommand "env"



