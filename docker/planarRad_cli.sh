#!/bin/bash
# Copyright Leigh Tyers 2024, GPLv3.0 License https://www.gnu.org/licenses/gpl-3.0.en.html

usage="usage: $(basename "$0") [-h] [-s n] <command> [<args>]

PlanarRad main command for docker image. Calls other planarRad programs normally in the directory \$JUDE2DIR

Available programs:
    calctool
    filetool
    phasetool
    skytool
    slabtool
    surftool
    wltool

Example Usage:
    $(basename "$0") slabtool --help

Other:
    -h  show this help text"



# Sort through parameters
while getopts ':hs:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

# Check that program name is valid
valid_programs="calctool \
    filetool \
    phasetool \
    skytool \
    slabtool \
    surftool \
    wltool"

contains() {
    # check if arg1 is in any of the other arguments
    if [[ " ${@:2} " =~ .*\ $1\ .* ]]; then
        echo 0
        return 0
    fi
    echo 1
    return 1
}

valid_cmd=$(contains $1 $valid_programs )
if [[ $valid_cmd != 0 ]]; then
    echo "Invalid program name $1"
    echo "$usage"
    exit 1
fi

# Run GNU options show c and show w


# Run planarrad program
cmd="$1_free"
echo Running command \'$cmd"${@:2}"\'
# Run command
$cmd "${@:2}"
