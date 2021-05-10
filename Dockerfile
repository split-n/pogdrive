FROM ruby:2.5-slim
RUN apt-get update -qq \
  && apt-get install -y build-essential libpq-dev curl gnupg2 shared-mime-info \
  && apt-get install -y vim-nox tmux
RUN curl https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
EXPOSE 3000 1234
CMD bundle exec rails s -p 3000 -b '0.0.0.0'
