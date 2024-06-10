#!/bin/bash

function generateIP() {
    str="";
    for i in 1 2 3 4
    do
        let "num=$RANDOM%256";
        str+=$num.;
    done
    str="${str%?}"
    echo $str
}

function responseCode() {
    code=(200 201 400 401 403 404 500 501 502 503);
    let "index=$RANDOM%10";
    echo ${code[$index]}
}

function generateMethods() {
    methods=("GET" "POST" "PUT" "PATCH" "DELETE");
    let "index=$RANDOM%5";
    echo ${methods[$index]}
}

function generateAgent() {
    agents=("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36" ,
	    "Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201" ,
	    "Opera/9.80 (X11; Linux i686; Ubuntu/14.10) Presto/2.12.388 Version/12.16.2",
	    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A",
            "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko",
	    "Mozilla/5.0 i(Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.19582");
    let "index=$RANDOM%6";
    echo ${agents[$index]};
}

generateURL() {
    protocol=("HTTP/1.0" "HTTP/1.1" "HTTP/2");
    URL=("google" "habr" "developer.mozilla" "opennet");
    let "indexP=$RANDOM%3";
    let "indexURL=$RANDOM%4";
    echo "${URL[$indexURL]} ${protocol[$indexP]}";
}

function main() {
    if [[ $# -ne 0 ]]
    then
        echo "Скрипт запускается без аргументов";
	exit 0;
    fi

    countStr=$(shuf -n1 -i 100-1000);
    for (( i=1; i<6; i++ ))
    do
    	nameFile="access_log$i.log";
        for (( str=0; str<countStr; str++ ))
        do
	    echo -n $(generateIP) >> $nameFile;
	    echo -n " - - " >> $nameFile; 
            echo -n "["$(date -d "$(( 6 - $i )) day ago + $str second" "+%d/%b/%Y:%H:%M:%S %z")"] \"" >> $nameFile;
	    echo -n "$(generateMethods) " >> $nameFile;
	    echo -n "/$(generateURL)\" " >> $nameFile;
	    echo -n "$(responseCode) \"-\" " >> $nameFile;
	    echo "\"$(generateAgent)\"" >> $nameFile;
    	done
	echo "файл записался";
    done
}

main $@

# URL запроса агента

# 200 - OK
# 201 - Created
# 400 - Bad Request
# 401 - Unauthorized
# 403 - Forbidden
# 404 - Not Found
# 500 - Internal Server Error
# 501 - Not Implemented
# 502 - Bad Gateway
# 503 - Service Unavailable
