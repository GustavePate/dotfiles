#!/bin/bash

rst2slides(){
    echo "param 1: doc rst"
    echo "param 2: nom du fichier à générer dans ~/pub/\$2.html"
    CUR_PATH=`pwd`

    # cp $1 ~/pub/src
    BASE=`basename $CUR_PATH`
    echo "construction de $1 du repertoire $BASE"

    cp -r ../$BASE ~/pub/src/


    cd ~/pub
    echo "ok"
    sed -e "s/\(\.\.\ image::\ \)ressources/\1src\/$BASE\/ressources/" ./src/$BASE/$1 > ./src/tmp.rst


    pandoc -f rst -t dzslides ./src/tmp.rst -o ~/pub/$2.html  --css ./dzslides/template.css  --template ./dzslides/dz_template.html
    cd $CUR_PATH
}

rst2slides $1 $2

