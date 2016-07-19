#! /bin/sh
# q1)1.	Write a shell script that uses a for loop to move a set of files from one 
# directory to another.
mkdir new_directory
cd ~/old_directory
for file in * ;do
	mv $file ~/new_directory 
done

