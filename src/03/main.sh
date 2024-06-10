. ../functions/correct.sh
. cleanLog.sh
. cleanMask.sh
. cleanTime.sh

function checkInput() {
    checkInput='^[1-3]';

    if [[ $# -ne 1 ]]
    then
        echo "Неверное количество аргументов";
        exit 1;
    fi

    if ! [[ $1 =~ $checkInput ]]
    then
        echo "Должно быль число от 1 до 3";   
        exit 1;
    fi
}

function parse() {
    if [[ $1 -eq "1" ]]
    then
        cleanLog;
    elif [[ $1 -eq "2" ]]
    then
        cleanTime;
    else [[ $1 -eq "3" ]]
        cleanMask;
    fi
}

function main() {
    checkInput $@;
    parse $@;
}

main $@
