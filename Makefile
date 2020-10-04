TAG=zakuro/dotfiles
docker-build:
	docker build -t ${TAG} .
docker-push:
	docker push zakuro/dotfiles:latest

docker:
	docker run -it ${TAG}

