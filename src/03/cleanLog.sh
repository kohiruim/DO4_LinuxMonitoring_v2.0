function  cleanLog()
{
    cd ../02;
    paths=$(awk '{print $3}' "02.log");
    reg='[0-9]$';

    for path in $paths
    do
        if [[ $path =~ $reg ]]
        then
            rm -rf $path;
        fi
    done
    rm ../02/02.log;
}
