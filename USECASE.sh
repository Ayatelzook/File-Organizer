#!/bin/bash

if [ ! -f "./function.sh" ]; then
    echo "File not exists"
 fi
 source  ./function.sh
 
function main () {

   declare path=$1
   declare file  
file=`iteration ${path}`
echo "$file"
printallfiles "$1"
}
main $1