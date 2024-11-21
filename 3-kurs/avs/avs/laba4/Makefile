# ЗАПУСКАТЬ ЧЕРЕЗ git bash

build: 
	docker build -t nginx-img -f nginx.Dockerfile .

run: 
	docker run -d -p $(port):80 -v $(shell pwd)/mnt/$(name)_web/:/var/www/html --name=$(name) nginx-img

stop: 
	docker stop $(name)

rm: 	
	docker rm $(name) 

rmi: 
	docker rmi nginx-img