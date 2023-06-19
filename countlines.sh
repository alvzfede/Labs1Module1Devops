#!/bin/bash
searching_by_owner(){
    owner="$1"
    echo "Looking files where the owner is: $owner"
    for file in *; do
        ownerFile=$(stat -f '%Su' $file)
        if [ "$owner" = "$ownerFile" ]; then
            name=$(stat -f $file)
            lines=$(wc -l < $file)
            totaLines=$(($lines+1))
            printf -v result 'File: %s, Lines: %s %-25s %s' "$name" "\t\t\t\t" "$totaLines" "$name"
            echo $result
        fi
    done
}

sarching_by_month(){
    month="$1"
    echo "Looking files where the month is: $month"
    for file in *; do
        monthFile=$(stat -f %SB $file)
        realMonth=$(awk '{print substr($0, 0, 3)}' <<< $monthFile)
        if [ "$month" = "$realMonth" ]; then
            name=$(stat -f $file)
            lines=$(wc -l < $file)
            totaLines=$(($lines+1))
            printf -v result 'File: %s, Lines: %s %-25s %s' "$name" "\t\t\t\t" "$totaLines" "$name"
            echo $result
        fi    
    done

}

while getopts "o:m:" opt; do
    case $opt in 
        o) searching_by_owner "$OPTARG";;
        m) sarching_by_month "$OPTARG";;
        *) exit 1;;
    esac
done