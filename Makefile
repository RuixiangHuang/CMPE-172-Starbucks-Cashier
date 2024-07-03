all: clean

clean:
	mvn clean

compile:
	mvn compile

run: compile
	mvn spring-boot:run

build:
	mvn package

run-jar: build
	java -jar target/spring-starbucks-casher-2.0.jar

# Docker

docker-build: build
	docker build -t spring-starbucks-casher .
	docker images

docker-run: docker-build
	docker run --name spring-starbucks-casher -td -p 80:8080 spring-starbucks-casher
	docker ps

docker-clean:
	docker stop spring-starbucks-casher
	docker rm spring-starbucks-casher
	docker rmi spring-starbucks-casher

docker-shell:
	docker exec -it spring-starbucks-casher bash

docker-push:
	docker login
	docker build -t raidenpoi/spring-starbucks-casher:v2.0 .
	docker push raidenpoi/spring-starbucks-casher:v2.0

# Compose

network-ls:
	docker network ls 

network-create:
	docker network create --driver bridge ${network}

network-prune:
	docker network prune

compose-up:
	docker-compose up --scale gumball=2 -d

compose-down:
	docker-compose down 	

lb-stats:
	echo "user = admin | password = admin"
	open http://localhost:1936

lb-test:
	open http://localhost


# Pod

pod-run:
	kubectl apply -f pod.yaml

pod-list:
	kubectl get pods

pod-desc:
	kubectl describe pods spring-gumball

pod-delete:
	kubectl delete -f pod.yaml

pod-shell:
	kubectl exec -it spring-gumball -- /bin/bash

pod-logs:
	kubectl logs -f spring-gumball

# Deployment

deployment-create:
	kubectl create -f deployment.yaml --save-config 

deployment-get:
	kubectl get deployments

deployment-get-pods:
	kubectl get pods -l name=spring-gumball

deployment-pod-shell:
	kubectl exec -it $(pod) -- /bin/bash

deployment-upgrade:
	kubectl apply  -f deployment.yaml

deployment-delete:
	kubectl delete deployment spring-gumball-deployment

# Service

service-create:
	kubectl create -f service.yaml

service-get:
	kubectl get services

service-get-ip:
	kubectl get service spring-gumball -o wide

service-delete:
	kubectl delete service spring-gumball

# Ingress

ingress-apply:
	kubectl apply -f ingress.yaml

ingress-ip:
	kubectl get ingress spring-gumball-ingress




