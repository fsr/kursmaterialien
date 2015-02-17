#!/bin/bash
# this script is used to initialize the folders for a new course

# helper function to reduce code duplication
# terminates the programm with an error message
# Usage: abort "mymessage"

function abort {
	echo $1
	echo "Aborted."
	exit
}

echo "Please enter the name of the new course:"
read COURSE_NAME

if [ -z COURSE_NAME]
then
	abort "Given course name was empty."
fi

if [ -d COURSE_NAME ]
then
	abort "A course with the given name already exists."
fi

# create the needed directories

mkdir $COURSE_NAME
mkdir "$COURSE_NAME/slides"
mkdir "$COURSE_NAME/exercises"
mkdir "$COURSE_NAME/latex"
mkdir "$COURSE_NAME/latex/img"

echo "Done."
