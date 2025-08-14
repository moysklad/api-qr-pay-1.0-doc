FROM ruby:2.7.5
COPY . /usr/src/app
VOLUME /usr/src/app
EXPOSE 4567
WORKDIR /usr/src/app
RUN apt-get update
RUN apt-get install -y nodejs
RUN gem install therubyracer -v '0.12.3' --source 'https://rubygems.org/'
RUN gem install bundler -v 1.16.6
RUN rm -rf /var/lib/apt/lists/*
RUN bundle install
CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]
