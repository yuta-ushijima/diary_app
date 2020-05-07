FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y nodejs

# Rails App
RUN mkdir /diary_app
WORKDIR /diary_app
ADD Gemfile /diary_app/Gemfile
ADD Gemfile.lock /diary_app/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . /diary_app
RUN mkdir -p tmp/sockets

# Expose volumes to frontend
VOLUME /diary_app/public
VOLUME /diary_app/tmp

# Start Server
# TODO: environment
CMD bundle exec puma