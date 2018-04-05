#!/bin/sh

echo Generating hash of $1 ...
HASH=$(md5sum $1 | cut -d" " -f1)
FILE=$(echo $1 | sed "s/.*\/\(.*\)/\1/g")
WORKDIR=/tmp/$HASH

echo Working in $WORKDIR

mkdir -p $WORKDIR

if [ ! -e $WORKDIR/$FILE.txt ]
then
    echo Generating objectdump ...
    objdump -lSd $1 > $WORKDIR/$FILE.txt
else
    echo Using cached objectump
fi

echo Parsing objectdump ...
cat $WORKDIR/$FILE.txt | \
    grep ".*\.[chS]:[0-9]\+" | \
    sed "s/\(.*\):[0-9]\+.*/\1/g" | \
    sort | \
    uniq | \
    xargs md5sum | \
    sed "s/\([0-9a-f]*\) *\(.*\)\/\(.*\)/\2\/\3 $(echo $WORKDIR | sed 's/\//\\\//g')\/src\/\/\1-\3/g" | \
    xargs -L1 -I % sh -c 'install -D %; printf "$(echo % | sed "s/.*\([0-9a-f]\{32\}\).*/\1/g" | cut -b1-6)\r"'

mkdir $WORKDIR/slocdata
sloccount --datadir $WORKDIR/slocdata $WORKDIR/src
