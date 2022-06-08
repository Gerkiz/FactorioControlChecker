#!/bin/sh

# Comment all maps that might be required
controlFile="control.lua"
originalSum=$(sha256sum "$controlFile" | awk '{print $1}')
grep -rl "ENABLE MAPS HERE" -A 500 "$controlFile" | grep -v "ENABLE MAPS HERE" | xargs sed -i "s/^require 'maps/--require 'maps/g"
changedSum=$(sha256sum "$controlFile" | awk '{print $1}')

echo "Original file sum:" "$originalSum"
echo "Changed file sum:" "$changedSum"


if (echo "$originalSum" "$controlFile" | sha256sum -c | grep -q "OK" > /dev/null 2>&1 ) ; then
  echo "Control does not differ"
  echo "::set-output name=should_run::0"
else
  echo "Control differs - push is needed"
  echo "::set-output name=should_run::1"
fi
