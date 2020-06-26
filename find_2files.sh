#!/bin/bash 

file1=$1
file2=$2

#a
if [[ ! -f $1 && ! -f $2 ]] 
then
  echo "$@ is not a file" 
else 
  echo "Given arguments are a path to a file"
fi

words_file1=$(cat ${file1})  
#words_file2=$(cat ${file2}) 



for word in $words_file1 
do
  found=$(grep "${word}" $2)
  echo "${found}"
done
