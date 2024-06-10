function createDir() #$1 - path $2-countFile $3-part
{
    countOut=0;
    for i in ${masDir[@]}
    do
        cd $1;
        mkdir $i;
        echo "$dateLog $sizeLog $1/$i" >> $pathLog/$nameLog;
        path2=$(pwd); path2=$path2/$i;
        createFile "$path2" $2 $3; 
    done
}

function createFile() #$1 - path $2-count $3-part
{
    cd $1;

    for((j=0; $j<$2 && $j<${#masFile[*]}; j=$(($j+1))))
    do
        freeMemory=$(df -hk / | awk 'sub(/dev/,""){printf("%d\n",$4) }');
        if [[ $freeMemory -lt 1000000 ]]
        then
            echo "Память закончилась, остался 1 Гб свободного места";
            if [[ "$3" -eq "2" ]]
            then
                stopScript;
            fi
            exit 1;
        else
            touch ${masFile[j]};
            fallocate -l $size ${masFile[j]};
	    echo "$dateLog $sizeLog $1/$i/${masFile[j]}" >> $pathLog/$nameLog;
        fi
    done
    ((countOut+=1));
    #echo "Заполнено файлами $countOut папок"
}
