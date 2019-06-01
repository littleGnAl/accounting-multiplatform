#!/usr/bin/env bash
set -e
set -x

output=$(dartfmt ./ -n)

if [[ -z ${output} ]]
  echo "The code style in ${output} is incorrect, make sure you follow the dart code style, please correct it by using dartfmt or manually."
  then exit 0
else
  exit 1
fi