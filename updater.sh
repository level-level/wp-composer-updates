#!/bin/bash

composer outdated --direct -m | while read line;
do
	read -a arr <<< $line
	plugin=${arr[0]}
	
	# Check if the line is actually for a package, and not an error.
	if ! [[ "$plugin" == *"/"* ]]; then
		continue;
	fi

	# Setup versions
	current=${arr[1]}
	latest=${arr[3]}

	# If no latest version is available, skip it
	if [[ -z $latest ]]; then
		continue
	fi

	echo "composer update ${plugin}"
	composer require "$plugin" &&
    git add composer.lock &&
    git commit -m "'update ${plugin} [${current} => ${latest}]'";
done;
