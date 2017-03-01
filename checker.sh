#!/bin/bash

prog_name=$1

if [ "X$prog_name" == "X" ]
then
    echo "Usage: $0 program do_clear"
    exit 0
fi

#is_cpp=$()

test_extension=".test"
answer_extension=".answer"

for a in *$test_extension
do
    if [ "X$2" != "X" ]
    then
        clear
    fi

    echo $a

    test_name=$(echo $a|cut -d . -f 1)
    answer_file=${test_name}$answer_extension

    if [ -f $answer_file ]
    then
        cat $a | python $prog_name > ${test_name}.out

        diff -q ${test_name}.out ${answer_file} > /dev/null

        if [ "X$?" == "X1" ]
        then
            echo -e "\e[1;31mWRONG ANSWER\e[0;30m"
        else
            echo -e "\e[1;32mOK\e[0;30m"
        fi
    else
        echo "Answer file $answer_file does not exist"
    fi

    if [ "X$2" != "X" ]
    then
        read
    fi
done
