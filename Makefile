ifeq  ($(shell uname),Darwin)
# OS X だった場合
$(eval file :=  docker-compose-darwin.yml)
else
# 上記以外だった場合
$(eval file :=  docker-compose-linux.yml)
endif

compose-build:
	sh docker_env.sh
	docker-compose -f $(file) build

compose-no-cache-build:
	sh docker_env.sh
	docker-compose -f $(file) build --no-cache

# コンテナ作成,バックグランド実行
compose-up:
	make trains-up
	docker-compose -f $(file) up -d
	echo  http://localhost:8888/lab?

# コンテナ削除,ネットワーク削除
compose-down:
	docker-compose -f $(file) down
	make trains-down

# trains-serverの初期化
trains-init:
	bash trains_setup.sh

# trains-serverの立ち上げ
trains-up:
	docker-compose -f data/trains-server/docker-compose-unified.yml up -d

# trains-serverのシャットダウン
trains-down:
	docker-compose -f data/trains-server/docker-compose-unified.yml down
