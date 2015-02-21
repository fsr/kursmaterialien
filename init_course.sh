#!/bin/bash

# this script is used to initialize the folders for a new course

TEMPLATE_DIR="./templates"
TEMPLATE_HTML_DESCRIPTION="course_description_template.html"
TEMPLATE_LATEX_SLIDES="slides_template.tex"
TEMPLATE_LATEX_INFO="course_info.tex"

# helper function to reduce code duplication
# terminates the programm with an error message
# Usage: abort "mymessage"

function abort {
	echo $1
	echo "Aborted."
	exit
}

# check the template directories
if [ -d $TEMPLATE_DIR ]
then
	if [ -f "$TEMPLATE_DIR/html/$TEMPLATE_HTML_DESCRIPTION" ]
	then
		echo "Templates found."
	else
		abort "Could not find template file $TEMPLATE_HTML_DESCRIPTION"
	fi
else
	abort "Could not find template directory $TEMPLATE_DIR"
fi

echo "Please enter the name of the new course:"
read COURSE_NAME

# get the name of the new course
if [ -z $COURSE_NAME ]
then
	abort "Given course name was empty."
fi

echo "If a course directory already exists and you wish to expand it,"
echo "enter is name here (without trailing \"/\")"
echo "If you wish to create a new one, just press enter."

read COURSE_DIR

if [ -z $COURSE_DIR ]
then
	COURSE_DIR="$COURSE_NAME"
fi

if [ ! -d $COURSE_DIR ]
then
	# create the needed directories
	mkdir $COURSE_DIR
	mkdir "$COURSE_DIR/slides"
	mkdir "$COURSE_DIR/slides/examples"
	mkdir "$COURSE_DIR/exercises"
	mkdir "$COURSE_DIR/latex"
	mkdir "$COURSE_DIR/latex/img"
	mkdir "$COURSE_DIR/latex/slides"
	mkdir "$COURSE_DIR/latex/exercises"
	mkdir "$COURSE_DIR/info"
	mkdir "$COURSE_DIR/info/html"
	mkdir "$COURSE_DIR/info/html/img"

	# copy the latex templates
	cp "$TEMPLATE_DIR/latex/$TEMPLATE_LATEX_SLIDES" \
	"$COURSE_DIR/latex/slides/$TEMPLATE_LATEX_SLIDES"
fi

# customize the course_info.tex
# and write it to the desired position
sed "s/COURSE..NAME/$COURSE_NAME/g" \
	"$TEMPLATE_DIR/latex/$TEMPLATE_LATEX_INFO" \
	> "$COURSE_DIR/latex/slides/$COURSE_NAME""_info.tex"

# customize the description html template 
# and write it to the desired position
sed "s/COURSE_NAME/$COURSE_NAME/g" \
	"$TEMPLATE_DIR/html/$TEMPLATE_HTML_DESCRIPTION" \
	> "$COURSE_DIR/info/html/$COURSE_NAME"".html"

echo "Done."
echo "Please do not forget to fill in "
echo "\t1) $COURSE_DIR/info/html/$COURSE_NAME"".html"
echo "\t2) $COURSE_DIR/latex/slides/$COURSE_NAME""_info.tex"
