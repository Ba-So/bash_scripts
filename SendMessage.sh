#!/bin/bash

SendMessage()
{
    com=$(tty)
    myname='Baso'
    echo $com 
    set 'who am i'
    who | grep -v '$1' >filef.txt

    exec < filef.txt
    array=""

    while read line
    do 
        set $line
        array+=($1)
    done

    rm filef.txt
    exec <$com

    echo "============> Select User Number <============="
    echo

    select userName in ${array[@]}
    do
        UserNam=$userName
        if [ -n $UserNam ]; then
            break
        fi
    done

    unset array #Clear the Array

    echo
    echo

    echo "============> Message Body <============="

    mesg y
    read -p "put your Message here==>" message1

    echo $myname : $message1 | write $UserNam

    if [ $? -eq 0 ]; then
        echo "sent"
    else
        echo "Message Failed to send ...................... No"
        echo "Maybe you don't have the rights"
        return 1
    fi
}

SendMessage
