#!/bin/bash
createImage="./createImage.sh"
alias kubectl="minikube kubectl --"
image="helloworld"
version="v1"
imagename="${image}:${version}"
now="$(date +%s)"
if [ -e sampledata.json ]
then
	echo "changing the build time in sampledata.json"
	deat="$(awk 'FNR == 4 { print $2 }' sampledata.json)"
	sed -i "s_${deat}_${now}_g " sampledata.json
	bash "$createImage"
else
	echo "File not found! Please checkin sampledata.json"
fi
sleep 1
kubectl create deployment ${image} --image=${imagename}
kubectl expose deployment ${image} --type=NodePort --port=80	
## To run the same image through docker ##
##	docker run -it -d -p 80:80 --name helloworld ${imagename}
echo "..Love from DevOps.."
