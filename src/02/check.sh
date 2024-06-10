function check()
{
    path=$1;
    slash=${path:0:1};
    checkSize='^[1-9][0-9]?[0]?Mb$';
    checkDir='^[a-zA-Z]{1,7}$';
    checkFile='^[a-zA-Z]{1,7}+([.][a-zA-Z]{1,3})?$';


    if [[ $# -ne 3 ]]
    then
        echo "Неверное количество аргументов";
        exit 1;
    fi

    if ! [[ $3 =~ $checkSize ]]
    then
        echo "Размер файла в килобайтах - целое число до 100. Пример; 3Mb";
        exit 1;
    fi

    if ! [[ $1 =~ $checkDir ]] || ! [[ $2 =~ $checkFile ]]
    then
        echo "В параметрах 3 и 5 дб буквы, максимальная длина - 7, максимальная длина расширения для файлов - 3";
        exit 1;
    fi
}