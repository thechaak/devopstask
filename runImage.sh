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
else
	echo "File not found! Please checkin sampledata.json"
fi
sleep 1
if [[ "$(nc -z 127.0.0.1 80 && echo 'IN USE' || echo 'FREE')" == "IN USE" ]]; then
	echo "Port 80 is already in use, Please stop the application or Update this file to run the image on other port"
	exit 0
else
	kubectl create deployment ${image} --image=${imagename}
	kubectl expose deployment ${image} --type=NodePort --port=80	
	## To run the same image through docker ##
	##	docker run -it -d -p 80:80 --name helloworld ${imagename}
echo "..Love from DevOps.."
fi

