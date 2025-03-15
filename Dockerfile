FROM ruby:3.2-slim

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update -qq && apt-get install -y build-essential \
  && bundle install \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY . .

CMD ["ruby", "main.rb"]