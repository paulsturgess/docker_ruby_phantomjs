FROM ubuntu:16.04
MAINTAINER Paul Sturgess
ENV REFRESHED_AT 2017-01-28

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  build-essential \
  libfontconfig \
  zlib1g-dev \
  libyaml-dev \
  libssl-dev \
  libgdbm-dev \
  libreadline-dev \
  libncurses5-dev \
  libffi-dev \
  bison \
  && rm -rf /var/lib/apt/lists/*

RUN wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz \
  && tar -xzvf ruby-install-0.6.1.tar.gz \
  && cd ruby-install-0.6.1/ \
  && make install \
  && rm -rf /usr/local/src/*

ENV RUBY_VERSION 'ruby 2.3.3'
RUN ruby-install --system $RUBY_VERSION

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv /phantomjs-2.1.1-linux-x86_64/bin/* /usr/local/bin

RUN mkdir -p /app
WORKDIR /app

RUN gem install bundler
