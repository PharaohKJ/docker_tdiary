
help:
	grep '^.\+:$$' Makefile

build:
	docker build -t pharaohkj/tdiary ./

run:
	docker run -d -p 28083:28083 -v /home/pharaohkj/webapps/datas/tdata_public:/var/www/public -v /home/pharaohkj/webapps/datas/tdata_docker:/var/www/data  -t -i pharaohkj/tdiary

run_redis:
	docker run -d --name redis -p 6379:6379 dockerfile/redis
