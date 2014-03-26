#!/bin/bash

N=20	# Task number 


# Coloring definitions.
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m'

cd ./tests
for n in {1..5} ; do
	echo -e "rm task_${blue}$N${NC}-${red}$n${NC}.in"
	rm task_$N-$n.in
	echo -e "rm task_${blue}$N${NC}-${red}$n${NC}.out"
	rm task_$N-$n.out
done
