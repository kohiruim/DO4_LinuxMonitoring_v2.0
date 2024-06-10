
function parsenameDefault() #nameDefault
{
    date=$(date +"%d%m%y");
    nameDefault=$1; out=""; type="";    # Default=az out=az_09112022
    isFile=0; index=0;                  # type =.az 
    if [[ "$nameDefault" == *"."* ]]
    then
        isFile=1;
        for((i=0; $i<${#nameDefault}; i=$(($i+1))))
        do
            if [[ ${nameDefault:$i:1} == "." ]]
            then
                break;
            fi
            ((index+=1));
        done
        type=$(echo ${nameDefault:$index});
        nameDefault=$(echo $nameDefault | sed "s/$type/""/");
        out=$nameDefault; out+="_"; out+=$date;
    else
        out=$nameDefault;
        out+="_"; out+=$date;
    fi
}

function correctName()
{
    # делает имена от 4 символов
    if [ ${#out} == '8' ]
    then
        a=${out:0:1}
        out=$(echo $out | sed "s/$a/$a$a$a/");
    elif [[ ${#out} == '9' ]]
    then
        a=${out:0:1};
        b=${out:1:1};
        out=$(echo $out | sed "s/$a$b/$a$a$b/");
    fi
}