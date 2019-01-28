build-dev:
	docker-compose build --build-arg SSH_KEY="$$(cat ~/.ssh/id_rsa)"
	docker-compose up