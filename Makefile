
help:
	grep '^.\+:$$' Makefile

build:
	docker build -t pharaohkj/tdiary ./

run:
	docker run -d --name tdiary -p 10080:28083 -v /Users/pharaohkj/dockerwork/tdiary/data/tdata_gem:/var/www/data  -t -i pharaohkj/tdiary

run_redis:
	docker run -d --name redis -p 6379:6379 dockerfile/redis
