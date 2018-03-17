From ubuntu:14.04
ENV CACHE_FLAG 0
RUN apt-get update
RUN apt-get upgrade -yqq
RUN apt-get update
RUN apt-get install -yqq build-essential gcc g++ openssl wget curl git-core libssl-dev libc6-dev gem
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \ 
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN git clone -b 3.0 https://github.com/antirez/redis.git
WORKDIR /redis
RUN make
RUN gem install redis
ADD conf/redis.conf redis.conf
ADD run.sh /run.sh
ENV REDIS_NODE_PORT=7000
ENTRYPOINT ["/bin/bash","/run.sh"]
