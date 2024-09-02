#!/bin/bash


usage="usage: $(basename "$0") [-h] [-s n] <command> [<args>]

PlanarRad main command for docker image. Calls other planarRad programs normally in $JUDE2DIR

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

# Sort through program arguments
programs_available="calctool \
    filetool \
    phasetool \
    skytool \
    slabtool \
    surftool\
    wltool"

[[ $programs_available =~ (^|[[:space:]])$1($|[[:space:]]) ]] && echo 'yes' || (echo "Command $1 not found"; echo "$usage"; exit 1)

# Run program
cmd="$1_free"
echo Running \'$cmd "${@:2}"\'
# Run command
$cmd "${@:2}"
