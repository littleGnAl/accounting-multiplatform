#!/usr/bin/env bash
set -e
set -x

output=$(dartfmt ./ -n)

if [[ -z ${output} ]]
  then exit 0
else
  echo "The code style in ${output} is incorrect, make sure you follow the dart code style, please correct it by using dartfmt or manually."
  exit 1
fi