#!/bin/sh

echo Generating hash ...
HASH=$(md5sum $@ | cut -d" " -f1 | sort | uniq | md5sum | cut -d " " -f1)
WORKDIR=/tmp/$HASH
mkdir -p $WORKDIR
echo Working in $WORKDIR

for binary in $@
do

    FILE=$(echo $binary | sed "s/.*\/\(.*\)/\1/g")

    echo Processing $FILE ...

    if [ ! -e $WORKDIR/$FILE.txt ]
    then
        echo Generating objectdump ...
        objdump -lSd $binary > $WORKDIR/$FILE.txt
    else
        echo Using cached objectump
    fi

    echo Parsing objectdump ...
    cat $WORKDIR/$FILE.txt | \
        grep "^/.*:[0-9]\+" | \
        sed "s/\(.*\):[0-9]\+.*/\1/g" | \
        sort | \
        uniq | \
        xargs md5sum | \
        sed "s/\([0-9a-f]*\) *\(.*\)\/\(.*\)/\2\/\3 $(echo $WORKDIR | sed 's/\//\\\//g')\/src\/\/\1-\3/g" | \
        xargs -L1 -I % sh -c 'install -D %; printf "$(echo % | sed "s/.*\([0-9a-f]\{32\}\).*/\1/g" | cut -b1-6)\r"'

done

mkdir -p $WORKDIR/slocdata
sloccount --datadir $WORKDIR/slocdata $WORKDIR/src
