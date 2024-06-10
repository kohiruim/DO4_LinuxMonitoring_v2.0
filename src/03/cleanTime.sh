. notice.sh

function cleanTime() {

    echo "Время начала и конца генерации брать из лог файла"
    echo "Напиши дату и время начала генерации файлов YYYY.MM.DD; Пример: '2022-11-25 17:28'"   
    read start;
    checkTime $start;
    echo "Напиши дату и время конца генерации файлов YYYY.MM.DD; Пример: '2022-11-25 17:28'"    
    read end;
    checkTime $end;

    deleteDir=$(find / -ignore_readdir_race  -type d -newermt "$start:00" ! -newermt "$end:59" | grep $(date +"%d%m%y") 2>/dev/null);
    deleteFile=$(find / -ignore_readdir_race  -type f -newermt "$start:00" ! -newermt "$end:59" | grep $(date +"%d%m%y") 2>/dev/null);

    delete=$deleteDir;
    notice;
    delete=$deleteFile;
    notice;
}

checkTime()
{
    str1=$1; str2=$2;
    checkTimeDate='^[1-9][0-9]{3}-([1][0-2]|[0][0-9])-([3][0-1]|[0-2][0-9])';
    checkTimeTime='([0-1][0-9]|[2][0-3]):([0-5][0-9])$'

    if ! [[ $1 =~ $checkTimeDate ]] || [[ $1 =~ $checkTimeTime ]] || [[ ${#str1} -ne 10 ]] || [[ ${#str2} -ne 5 ]]
    then
        echo "Косяк в дате"
        exit 0;
    fi
}
