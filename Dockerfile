FROM ruby:2.7

RUN gem install bundler

COPY . app
WORKDIR /app
