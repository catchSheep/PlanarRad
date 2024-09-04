#!/bin/bash
# PlanarRad docker entrypoint CLI
# Copyright (C) 2024 Leigh Tyers

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
