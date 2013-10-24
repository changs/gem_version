#!/bin/sh

cat "./$1" | grep '(\d' | sed 's/^ *//g' | while read line
do
  gem=`echo $line | cut -d '(' -f1`
  version=`echo $line | cut -d '(' -f2 | sed 's/.$//'`
  latest_version=`curl -s https://rubygems.org/api/v1/versions/$gem.json | egrep -oh 'number":"(\w|\.)*"' | head -n1 | cut -d ":" -f2 | sed 's/"//g'`
  if [ "$version" != "$latest_version" ]; then
    echo "You're using: \x1B[00;34m$gem\x1B[00m\x1B[00;31m$version\x1B[00m. The latest version is \x1B[00;32m$latest_version\x1B[00m"
  fi
done

