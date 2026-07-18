
PERCENT=30

if [[ $# -le 0 ]]; then
    printf "Using default value of ${PERCENT} for threshold.\n"
else
    if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]]; then
        PERCENT=$1
    else
        echo "INVALID INPUT"
        exit 1
    fi
fi

#let "PERCENT += 0"
#printf "Threshold = %d\n" $PERCENT
echo "Threshold = $PERCENT"
df -Ph | grep -i root | awk '{ print $5,$1 }' | while read data; do
    usedspace=$(echo $data | awk '{print $1}' | sed s/%//g)
    partition=$(echo $data | awk '{print $2}')
    if [ $usedspace -ge $PERCENT ]; then
        echo "WARNING: The partition \"$partition\" has used $usedspace% of total available space and above Threshold  of $PERCENT  - Date: $(date)"
    else
        echo "Your Disk Space of \"$partition\" is well below the Threshold  of $PERCENT and current utilization is $usedspace% ."
    fi
done
