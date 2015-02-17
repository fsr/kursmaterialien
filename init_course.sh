#!/bin/bash

# this script is used to initialize the folders for a new course

TEMPLATE_DIR="./templates"

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

if [ -z $COURSE_NAME ]
then
	abort "Given course name was empty."
fi

if [ -d $COURSE_NAME ]
then
	abort "A course with the given name already exists."
fi

# create the needed directories

mkdir $COURSE_NAME
mkdir "$COURSE_NAME/slides"
mkdir "$COURSE_NAME/slides/examples"
mkdir "$COURSE_NAME/exercises"
mkdir "$COURSE_NAME/latex"
mkdir "$COURSE_NAME/latex/img"
mkdir "$COURSE_NAME/latex/slides"
mkdir "$COURSE_NAME/latex/exercises"
mkdir "$COURSE_NAME/info"
mkdir "$COURSE_NAME/info/html"
mkdir "$COURSE_NAME/info/html/img"

# copy template files

if [ -d $TEMPLATE_DIR ]
then
	cp -r "$TEMPLATE_DIR/html/*" "$COURSE_NAME/info/html/"
	cp -r "$TEMPLATE_DIR/latex/*" "$COURSE_NAME/latex/"
else
	echo "Template directory missing, no files where copied."
fi

echo "Done."
