FROM ruby:2.7.3-alpine

# Install system dependencies
RUN apk add --no-cache tzdata build-base postgresql-dev nodejs yarn

# Install ruby dependencies
ADD Gemfile Gemfile.lock .
RUN bundle install --deployment --without development,test --jobs "$(nproc)"

# Install node dependencies
ADD package.json yarn.lock
RUN yarn

ADD . .

RUN bin/rails assets:precompile

CMD bin/rails server
