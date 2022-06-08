#!/bin/sh

# Comment all maps that might be required
set -f
controlFile="control.lua"
originalsum=$(sha256sum $controlFile | awk '{print $1}')
grep -rl "ENABLE MAPS HERE" -A 500 $controlFile | grep -v "ENABLE MAPS HERE" | xargs sed -i 's/^require \x27maps/--require \x27maps/g'
changedsum=$(echo $originalsum $controlFile | sha256sum -c)

if echo "$changedsum" | grep -q "OK" ; then
	echo "Control does not differ"
	echo "::set-output name=should_run::0"
else
	echo "Control differs - push is needed"
	echo "::set-output name=should_run::1"
fi

