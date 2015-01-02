task help: [] do
  sh 'rake -T'
end

desc 'build'
task build: [:build_core]

desc 'rebuild'
task rebuild: [:set_rebuild, :build_core]

rebuild = false

task build_core: [] do
  sh "docker build --no-cache=#{rebuild} -t pharaohkj/tdiary ./"
end

task set_rebuild: [] do
  rebuild = true
end

desc 'run'
task run: [] do
  sh "docker run -d -p 28083:28083 --link redis:redis \
      -v /home/pharaohkj/webapps/datas/tdata_public:/var/www/public \
      -v /home/pharaohkj/webapps/datas/tdata_docker:/var/www/data \
      -t -i pharaohkj/tdiary"
end

desc 'rm'
task rm: [] do
  sh 'docker rm tdiary'
end

task run_redis: [] do
  sh 'docker run -d --name redis -p 6379:6379 dockerfile/redis'
end

task rm_redis: [] do
  sh 'docker rm redis'
end
