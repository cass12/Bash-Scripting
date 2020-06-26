#!/bin/bash 

for arg in "$@"
do
   if [[ -d ${arg} ]]; then
       echo "Argument is directory"
	nr_files=$(find $arg -type f | wc -l)
 	echo "Nr of files in current directory: $nr_files"
   elif [[ -f ${arg} ]]; then
       echo "Argument is a file"
	nr_chars=$(wc -c $arg)
  	echo "Number of characters in file: $nr_chars"
	odd_lines=$(sed -n 1~2p $arg)
	even_lines=$(sed -n 2~2p $arg)
	count_odd=0
	count_even=0
	for word in $odd_lines 
	do 
	  if [[ ${#word}%2 -eq 0 ]]; then
		odd_index=$(grep -n "$word" $arg | grep -Eo '^[^:]+' )
		echo "Even length words from odd lines are: $word and line no is $odd_index"
		((count_even=count_even+1))
	  fi
	done
	for word in $even_lines
	do
	  if  [[ ${#word}%2 -eq 1 ]]; then
		even_index=$(grep -n "$word" $arg | grep -Eo '^[^:]+' )
		echo "Odd length words from even lines are: $word and line no. is $even_index" 
		((count_odd=count_odd+1))	  
	  fi
	done 
	echo "No. of odd length words in even lines is $count_odd"
        echo "No. of even length words in odd lines is $count_even"
   elif [[ -h ${arg} ]]; then 
       echo "Argument is symbolic link"
        sym_link=$(readlink -f <linkname>)  
 	echo "This link points to $sym_link"
   else 
       echo "Not a valid argument: use file, directory or symlink" 
       exit 1
   fi
done
