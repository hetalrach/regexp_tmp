#!/bin/bash

#Get args processing


validate_usage()
{
	keyword=$*
	if [ $set_specified -ne 1 ]
	then
		echo "set name has to be speficied"
		exit
	fi
	operations=$(($writeupoption + $inputoption + $outputoption + $testoption))

	if [ $operations -ne 1 ]
	then
		echo "atleast and only 1 of -w (writeup) -i (input) -o (output) -t (test) has to be used"
		exit
	fi
	perform_set_operation
}

perform_set_operation()
{
	if [ $writeupoption -eq 1 ]
	then
		perform_writeup_option
	fi
	if [ $outputoption -eq 1 ]
	then
		perform_output_option
	fi
	if [ $inputoption -eq 1 ]
	then
		perform_input_option
	fi
	if [ $testoption -eq 1 ]
	then
		perform_test_option
	fi
}

perform_test_option()
{
	echo "Input the regular expression:"
	command_part1='cat $PWD/$SETNAME/input | grep '
	echo $command_part1
	read regexp
	full_command=$command_part1$regexp
	echo $full_command
	echo $regexp
	echo cat $PWD/$SETNAME/input \| grep $regexp
	cat $PWD/$SETNAME/input | grep $regexp
}
perform_input_option()
{
	cat $PWD/$SETNAME/input
}
perform_output_option()
{
	cat $PWD/$SETNAME/output
}
perform_writeup_option()
{
	cat $PWD/$SETNAME/write-up
}

set_specified=0
writeupoption=0
inputoption=0
outputoption=0
testoption=0

while getopts ":s:iotw" options
do
	case "${options}" in
		s)
			SETNAME=${OPTARG}
			set_specified=1
			;;
		i)
			inputoption=1
			;;
		o)
			outputoption=1
			;;
		t)
			testoption=1
			testregexp=${OPTARG}
			;;
		w)
			writeupoption=1
			;;
		*)
			exit_abnormal
			;;
	esac
done
validate_usage $*

