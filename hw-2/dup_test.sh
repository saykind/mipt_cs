#!/bin/bash

N=17 	# from
M=19	# to 


# Coloring definitions.
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m'


cd ./tests
for n in {1..5} ; do
	echo -e "cp task_${blue}$N${NC}-${red}$n${NC}.in task_${blue}$M${NC}-${red}$n${NC}.in"
	cp task_$N-$n.in task_$M-$n.in
	echo -e "touch task_${blue}$N${NC}-${red}$n${NC}.out"
	touch task_$N-$n.out
done
