#!/bin/bash
#-----------------------------------------------------------------------------
# File    : install-m.sh
# Contents: installation script for matlab tools
# Author  : Kristian Loewe
#-----------------------------------------------------------------------------

usage() {
  printf "%s\n" "usage: install-m.sh [options] <mod-dir> <tgt-dir>"
  printf "%s\n" "  --octave  install for GNU Octave instead of Matlab"
}

set -e

mod_dir=""
tgt_dir=""
octave=""

if   [ "$#" -eq 2 ]; then
  mod_dir="$1"
  tgt_dir="$2"
elif [ "$#" -eq 3 ]; then
  octave="$1"
  if [ ! "$octave" == "--octave" ]; then
    printf "Invalid option specified\n"
    usage
    exit 1
  fi
  mod_dir="$2"
  tgt_dir="$3"
else
  printf "Illegal number of arguments.\n"
  usage
  exit 1
fi

if [ ! -n "${mod_dir}" ] && [ ! -n "${tgt_dir}" ]; then
  usage
  exit 1
fi

mod_dir=`readlink -f ${mod_dir}`
tgt_dir=`readlink -f ${tgt_dir}`

if [ -d ${tgt_dir} ]; then
  printf "The target directory exists. Overwrite?\n"
  select yn in "yes" "no"; do
    case $yn in
      yes ) rm -r ${tgt_dir}; break;;
      no ) exit;;
    esac
  done
fi

if [ "$octave" == "--octave" ]; then
  if [ ! -f ${mod_dir}/src/makefile-oct ]; then
    printf "Installation for GNU Octave is not supported for this module.\n"
    exit 1
  fi
  if [ -z `which octave` ]; then
    printf "Octave not found. Aborting.\n"
    exit 1
  fi
else
  if [ -z `which matlab` ]; then
    printf "Matlab not found. Aborting.\n"
    exit 1
  fi
fi

current_dir=`pwd`
printf "Compiling ... "
if [ ! -d "${mod_dir}/private" ]; then
  mkdir ${mod_dir}/private
fi
cd ${mod_dir}/src
if [ "$octave" == "--octave" ]; then
  make -f makefile-oct > make-oct.log
else
  make > make.log
fi
cd ${current_dir}
printf "[done]\n"
printf "Installing ... "
mkdir -p ${tgt_dir}/private
#cp ${mod_dir}/../version ${tgt_dir}

if  [ "$octave" == "--octave" ]; then
  cp ${mod_dir}/private/*.mex ${tgt_dir}/private/
else
  cp ${mod_dir}/private/*.mex?* ${tgt_dir}/private/
fi

cp ${mod_dir}/*.m ${tgt_dir}
printf "[done]\n"

exit 0
