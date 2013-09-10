#!/bin/bash

rm -rf www
node_modules/.bin/brunch build -o
