function check() {
    checkInput='^[1-4]';

    if [[ $# -ne 1 ]]
    then
        echo "Неверное количество аргументов";
        exit 1;
    fi

    if ! [[ $1 =~ $checkInput ]]
    then
        echo "Аргументом должно быль число от 1 до 4";
        exit 1;
    fi
}

function sorting() {
    check $@;
    if [[ $1 -eq "1" ]]
    then
        awk '{print $0}' ../04/*.log | sort -nk 9;
    elif [[ $1 -eq "2" ]]
    then
        awk '{print $1}' ../04/*.log | sort -uk 1;
    elif [[ $1 -eq "3" ]]
    then
        awk '{if($9 ~/^[45]/) print $0}' ../04/*.log;
    else
        awk '{if($9 ~/^[45]/) print $1}' ../04/*.log | sort -uk 1;
    fi
}

sorting $@
