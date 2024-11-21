build: 
	docker build -t docker-h1 -f ./host1.Dockerfile ./ 
	docker build -t docker-h2 -f ./host2.Dockerfile ./ 

run: 
	docker run -d --name docker-h1-cont -p 22:22 -v F:/avs/laba3/mnt/host1/home:/home -v F:/avs/laba3/mnt/host1/root:/root docker-h1 
	docker run -d --name docker-h2-cont -p 23:22 -v F:/avs/laba3/mnt/host2/home:/home -v F:/avs/laba3/mnt/host2/root:/root docker-h2 

stop: 
	docker stop docker-h1-cont
	docker stop docker-h2-cont

rm: 
	docker rm docker-h1-cont
	docker rm docker-h2-cont

rmi: 
	docker rmi docker-h1 
	docker rmi docker-h2

copykeys: 
	cp ./keys/avs_key.pub ./mnt/host1/root/.ssh/authorized_keys
	cp ./keys/avs_key.pub ./mnt/host2/root/.ssh/authorized_keys