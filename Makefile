ifdef ssh_key_path
	SSH_KEY_PATH="$$(cat $(ssh_key_path))"
else
	SSH_KEY_PATH="$$(cat ~/.ssh/id_rsa)"
endif

build-dev:
	docker-compose build --build-arg SSH_KEY=$(SSH_KEY_PATH)
	docker-compose up