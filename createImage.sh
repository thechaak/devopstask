#!/bin/bash
image="helloworld"
version="v1"
imagename="${image}:${version}"
now="$(date +%s),"
if [ -e sampledata.json ]
then
	echo "changing the build time in sampledata.json"
	bat="$(awk 'FNR == 3 { print $2 }' sampledata.json)"
	sed -i "s_${bat}_${now}_g " sampledata.json
       cat sampledata.json	
else
	echo "File not found! Please checkin sampledata.json"
fi

if [[ "$(docker image inspect ${imagename} --format='imageYes' 2> /dev/null)" == "imageYes" ]]; then
	echo "${imagename} already exists!"
else
docker build -t ${imagename} .
fi
