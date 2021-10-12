#!/usr/bin/bash

get-key () {
   file=$1
   echo "demo object is : `cat $file`"
   k=$2
   echo "Nested key for this object : `cat $k`"
   key1=`cat $k | cut -d "/" -f1`
   key2=`cat $k | cut -d "/" -f2`
   key3=`cat $k | cut -d "/" -f3`
   #k=`echo "$k" | sed  's/\//./g'`
   value=`cat $file | /c/Users/Himanshu/Downloads/jq.exe -r --arg k1 "$key1" --arg k2 "$key2" --arg k3 "$key3" '.[$k1][$k2][$k3]'`
   echo "Value for requested key is : $value"
}

get-key ./f1.json ./key1.txt
