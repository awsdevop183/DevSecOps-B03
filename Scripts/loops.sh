
#!/bin/bash

for num in {1..10}
do
    echo $num
done


Even numbers and odd number

for I in {1..20}
do
    
    if [ $(expr $I % 2) -eq 0 ]
    then
        echo "$I an even number"
    else
        echo "=======$I is an odd number====="
    fi
done


I=0
while [ $I -le 15 ]
do
    if [ $(expr $I % 2) -eq 0 ]
    then
        echo "$I an even number"
    else
        echo "=======$I is an odd number====="
    fi
    I=$(($I+1))
    
done









#!/bin/bash

echo "Hostname is $(cat /etc/hostname)"