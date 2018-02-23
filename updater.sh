ITER=1

for plugin in $(composer outdated --direct -m);
do
	Q=`expr $ITER % 2`
    if [ $Q -eq 0 ]
    then
    	ITER=$(expr $ITER + 1)
    	continue # Skip current version number
    fi
    Q=`expr $ITER % 3`
    if [ $Q -eq 0 ]
    then
    	ITER=0
    	continue # Skip available version number
    fi
    composer update "$plugin" &&
    git add composer.lock &&
    git commit -m "'update $plugin plugin'";
    ITER=$(expr $ITER + 1)
done;