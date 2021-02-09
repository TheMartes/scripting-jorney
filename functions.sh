#!/bin/bash

function ask_for_name() {
    echo "please enter your name: "
    read name

    if [[ -z ${name} ]]
    then
        echo "Please enter your name"
    else
        echo "Hello ${name} 👋"
    fi
}

ask_for_name
