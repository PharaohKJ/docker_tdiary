FROM debian

MAINTAINER PharaohKJ <kato@phalanxware.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get -y install \
    apache2-utils \
    build-essential \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    zlib1g-dev && \
    apt-get clean && \
    curl -O http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz && \
    tar -zxvf ruby-2.1.5.tar.gz && \
    cd ruby-2.1.5 && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-2.1.5 ruby-2.1.5.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc
RUN mkdir -p /var/www && \
    cd /var/www && \
    gem install tdiary && \
    tdiary new ./ --skip-bundle
RUN echo "gem 'unicorn'" >> /var/www/Gemfile.local && \
    echo "gem 'tdiary-style-gfm'" >> /var/www/Gemfile.local && \
    echo "gem 'tdiary-contrib'" >> /var/www/Gemfile.local
# RUN echo "gem 'tdiary-cache-redis'" >> /var/www/Gemfile.local
RUN cd /var/www/ && bundle install --without test development
RUN sed -i "s/@style = 'Wiki'/@style = 'GFM'/" /var/www/tdiary.conf
COPY unicorn.conf /var/www/
RUN htpasswd -dbc /var/www/.htpasswd tdiaryman tdiaryman
RUN curl -o theme.tar.gz http://www.tdiary.org/download/tdiary-theme-v4.1.1.tar.gz && \
    tar -zxvf theme.tar.gz && \
    mv tdiary-theme-v4.1.1/* /var/www/theme/
RUN mkdir -p /var/www/log
RUN mkdir -p /var/www/data
COPY my_plugins/* /var/www/misc/plugin/
COPY start.sh /start.sh
# CMD cd /var/www && bundle exec tdiary server
# CMD cd /var/www && bundle exec unicorn -c unicorn.conf
CMD /start.sh
