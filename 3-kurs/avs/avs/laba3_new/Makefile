PWD := $(shell pwd)

docker-build:
	docker build -t ans-manager -f manager.Dockerfile .
	docker build -t ans-host -f ansible.Dockerfile .

docker-rmi: docker-rm
	docker rmi ans-manager
	docker rmi ans-host

docker-run: 
	docker run -d -p 2222:22 --name ans1-host -v $(PWD)/mnt/ans1-mnt:/home/ansible/saves ans-host
	docker run -d -p 2223:22 --name ans2-host -v $(PWD)/mnt/ans2-mnt:/home/ansible/saves ans-host 
	docker run -d -p 2224:22 --name ans-manager -v $(PWD)/mnt/manager-mnt:/home/ansible/saves ans-manager

docker-rm: docker-stop
	docker rm ans1-host || true 
	docker rm ans2-host || true 
	docker rm ans-manager || true 

docker-stop: 
	docker stop ans1-host || true  
	docker stop ans2-host || true 
	docker stop ans-manager || true 

gen-key: 
	ssh-keygen -t rsa -b 2048 -f $(PWD)/keys/id_rsa


# После запуска контейнера 
# Зайти в него командой docker exec -it ans-manager bash
# и выполнить команду mv ansible saves