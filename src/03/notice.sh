function notice() {
    echo "Скрипт удалит эти файлы, продолжить? y/n"     
    for i in $delete
    do
        echo $i;
    done
    read answer;

    if [[ "$answer" == "y" ]] || [[ "$answer" == "Y" ]] 
    then
        rm -rf $delete;

        if [[ -f ../02/02.log ]]
        then
             rm ../02/02.log;
        fi
    fi
}
