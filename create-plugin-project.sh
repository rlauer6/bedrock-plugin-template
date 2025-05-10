#!/usr/bin/env bash
# -*- mode: bash; tab-width: 2; -*-
# Generate a new Bedrock plugin structure from a template

set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 -m <module> -e <email> -g <github> -a <author>
  -m  Module name (e.g., MyApp)
  -e  Email address
  -g  GitHub username
  -a  Author full name
EOF

  exit 1
}

# Read args
module=""
email=""
github=""
author=""

while getopts "m:e:g:a:h" opt; do
  case "$opt" in
    m) module="$OPTARG" ;;
    e) email="$OPTARG" ;;
    g) github="$OPTARG" ;;
    a) author="$OPTARG" ;;
    h) usage ;;
    \?) echo "Error: invalid option -$OPTARG" >&2; usage ;;
    :) echo "Error: option -$OPTARG requires an argument." >&2; usage ;;
  esac
done

# Check required
if [[ -z $module ]]; then
  echo "Error: module (-m) is required." >&2
  usage
fi

readonly module email github author

lc_module=$(echo $module | tr A-Z a-z)

# Confirm before overwriting existing files
for f in buildspec.yml Makefile "test-$lc_module.pl" "t/00-$lc_module.t"; do
  if [[ -e $f ]]; then
    read -rp "File '$f' exists. Overwrite? [y/N] " ans
    [[ $ans =~ ^[Yy]$ ]] || { echo "Aborting."; exit 1; }
  fi
done

mkdir -p lib/BLM/Startup t bin share

bedrock buildspec.roc module="$module" author="$author" \
                      email="$email" github_user="$github" > buildspec.yml

bedrock Makefile.roc module="$module" > Makefile

bedrock 00-test.roc module="$module" > t/00-$lc_module.t

bedrock test-plugin.roc module=$module > test-$lc_module.pl

bedrock-plugin -r -m "$module" -a "$author" -e "$email"

tar xvf "$module.tgz" -C lib

rm $module.pm $lc_module.xml "$module.tgz"

mv lib/*.roc . && mv lib/*.xml share/

chmod 755 "test-$lc_module.pl"

chmod 755 "t/00-$lc_module.t"

touch ChangeLog
