# main.sh /opt/test 4 az 5 az.az 3kb
# для az максимальное количество = +-244; Для других строк = +-(255-7-len(str))*2;

. check.sh
. ../functions/generate.sh
. ../functions/create.sh
. ../functions/correct.sh

main()
{
    check $@;

    if [[ -f 01.log ]]
    then
	rm 01.log;
    fi
    
    touch 01.log;
    nameLog=01.log; dateLog=$(date +"%d.%m.%y"); sizeLog=$6; pathLog=$(pwd);
    masDir=(); masFile=(); size=$6; path=$1;
    size=$(echo $size | sed "s/kb/K/");
    
    count=0;
    parsenameDefault $3;
    correctName;
    generateName $2 $3;
    backGenerateName $(($2-$count));

    count=0;
    parsenameDefault $5;
    correctName;
    generateName $4 $5;
    backGenerateName $(($4-$count));

    createDir $path $4 1;

}

main $@
