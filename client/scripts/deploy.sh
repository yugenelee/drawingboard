#!/bin/bash


if [ "$1" != "" ]
then
	git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." rm -rf --cached /var/www/staging/.
    git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." add /var/www/staging/.
    git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." commit -m "BEFORE $1"
	rm -rf www
    node_modules/.bin/brunch build -o
    rm -rf /var/www/staging/*
    cp -rp www/* /var/www/staging/.
    git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." rm -rf --cached /var/www/staging/.
    git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." add /var/www/staging/.
    git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." commit -m "$1"
    git --git-dir="/var/www/staging/.git" --work-tree="/var/www/staging/." push -u origin master
else
	echo 'Please enter a message'
fi
