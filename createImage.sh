#!/bin/bash
image="helloworld"
version=$(date +"%D-%T")
imagename="${image}:${version}"
now="$(date +%s),"
if [ -e sampledata.json ]
then
	echo "changing the build time in sampledata.json"
	bat="$(awk 'FNR == 3 { print $2 }' sampledata.json)"
	sed -i "s_${bat}_${now}_g " sampledata.json
else
	echo "File not found! Please checkin sampledata.json"
fi
docker build -t ${imagename} .
echo ${imagename} > delete
