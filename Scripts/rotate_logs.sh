
#!/bin/bash

read -p "Enter The File Path(Eg:/var/log/nginx/access.log): " f
if [ ! -f $f ]; then
    echo $f does not exist!
    exit
fi

MAXSIZE=$((10 * 1024))

# size=$(du -b ${f} | tr -s '\t' ' ' | cut -d' ' -f1)
size=$(du -b ${f} | tr -s '\t' ' ' | cut -d' ' -f1)
if [ ${size} -gt ${MAXSIZE} ]; then
    echo Rotating!
    timestamp=$(date +%s)
    mv ${f} ${f}.$timestamp
    touch ${f}
else
    echo "The file ${f} size is less than 10MB. No need to rotating."
fi
