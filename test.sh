#!/bin/sh

cd "${0%/*}/ext"

rm -f Makefile
rm -f stat_flags.bundle

ruby extconf.rb
make

mkdir -p hide
chflags hidden hide

output="$(ruby -I . -r stat_flags -e "print File.stat('hide').flags.to_s(8)")"

rmdir hide

if test "$output" != "100000"; then
  # 100000 is octal

  echo "'$output' is not '100000'."
  exit 1
fi

