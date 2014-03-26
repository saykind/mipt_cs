#!/bin/bash

N=20	
# Task number 


# Coloring definitions.
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m'


echo -e "\ngcc -m32 ${blue}task_$N.s${NC} -o task.out"
gcc -m32 task_$N.s -o task.out

cd ./tests
echo ""
for n in {1..5} ; do
	../task.out <task_$N-$n.in >task_$N-$n.out
	echo -e "./task.out ${green}<${NC}task_${blue}$N${NC}-${red}$n${NC}.in \
${green}>${NC}task_${blue}$N${NC}-${red}$n${NC}.out"
done
echo ""
for n in {1..5} ; do
	echo ""
	cat task_$N-$n.in
	cat task_$N-$n.out
done
echo ""
rm ../task.out
