#!/bin/bash

# print
echo ":)"

# Arguments passing
#echo "argument one $1" # first argument
#echo "arguments are: $*" # all arguments


#echo "\n
#-------------------\n
#\n"

# Arrays
arr=("key1" "key2" "key3")

# get second element
# echo ${arr[1]} # use ${arr[@]} to output everything
admin="martes"

: <<'END'
# if statements
read -p "What is your username: " username

if [[ "${username}" != "${admin}" ]]
then
    echo "You're not allowed to enter."
else
    echo "Hi there ${username} 👋"
fi
END

: <<'END'
users="melania alzbeta erzebeta"

for user in $users
do
    echo ${user}
done
END

# For Loop
for num in {1..10} ; do
    echo ${num}
done

echo "Enter your name: "
read name

while [[ -z ${name} ]] ; do
    echo "You need to enter your name"
    read name
done 

echo "Hello ${name} 👋"
