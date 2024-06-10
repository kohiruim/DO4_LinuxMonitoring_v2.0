#!/bin/bash

if [[ $# -ne 0 ]]
then
    echo "Не должно быль аргументов";
    exit 0;
else
    goaccess ../04/*.log --log-format=COMBINED > index.html;
fi
