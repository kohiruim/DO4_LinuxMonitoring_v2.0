# для az максимальное количество = +-244; 
# Для других строк = +-(248-len(str))*2;

function generateName() #count name
{
    default=$out; len=$((${#out}+${#type}));

    while [ $count -lt $1 ] && [[ $len  -lt 255 ]]
    do
        for((i=0; $i<${#nameDefault} && count<$1 && $len<255; i=$(($i+1))))
        do
            c="${nameDefault:$i:1}"
            indexOut=0;
            while [[ ${out:$indexOut:1} != $c ]]
            do
                ((indexOut+=1));
            done
            out=$(echo $out | sed "s/$c/$c$c/");
            len=$((${#out}+${#type}));
            outType=$out$type
            if [[ "$2" == *"."* ]] && ! [[ "${masFile[@]}" =~ "${outType}" ]]
            then
                masFile[count]=$out$type;
                ((count+=1));
            elif ! [[ "${masFile[@]}" =~ "${outType}" ]]
            then
                masDir[count]=$out;
                ((count+=1));
            fi
        done
    done
}

function backGenerateName() #count
{
    if [[ "$nameDefault" != "az" ]] && [[ $1 -gt 0 ]]
    then
        nameDefault=$(echo $nameDefault | rev);
        out=$nameDefault; out+="_"; out+=$date;
        correctName;
        generateName $(($count+$1)) $nameDefault$type;
    fi
}