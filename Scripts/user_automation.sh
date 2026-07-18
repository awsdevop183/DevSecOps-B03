#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Please enter atleast one username:"
else
    
    for USER in $@
    do
        if [[ $USER =~ ^[a-z]+$ ]]
        then
            
            EXISTING_USER=$(cat /etc/passwd | grep -w $USER | cut -d ":" -f 1)
            echo "entered username: $USER"
            if [ "${USER}" = "${EXISTING_USER}" ]
            then
                echo "$USER already exists, please enter new username"
                
            else
                SPECIAL=$(echo '!@#$%&()_' | fold -w1 | shuf | head -1)
                PASSWORD="Passw0rd${RANDOM}${SPECIAL}"
                JUMBLED_PASSWORD=$(echo ${PASSWORD} | fold -w1 | shuf | tr -d "\n")
                
                sudo useradd -m -s /bin/bash $USER
                echo "password is ${JUMBLED_PASSWORD}"
                echo "$USER:$JUMBLED_PASSWORD" | sudo chpasswd
                
            fi
        else
            echo "Please enter a valid username, you entered $USER"
        fi
    done
    
fi
