#!/bin/bash

WORD=$1
REVERSE=''

LEN=`expr ${#WORD} - 1`

for (( i=$LEN; i>=0; i-- ));
do
    # echo ${WORD[@]:$i:1};
    REVERSE=$REVERSE${WORD[@]:$i:1}
done

if [ ${WORD,,} = ${REVERSE,,} ]
then
    echo "$WORD is a palindrome"
else
    echo "$WORD is not a palindrome"
fi

