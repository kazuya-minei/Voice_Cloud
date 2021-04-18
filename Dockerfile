FROM ruby:2.6.6

# Install nodejs
RUN apt-get update -qq && apt-get install -y build-essential libxslt-dev libxml2-dev cmake
RUN apt-get install -y nodejs npm && npm install n -g && n 12.13.0

# Add Yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update
RUN apt-get update -y

# Install Yarn
RUN apt-get install yarn -y

ADD . /usr/src/voice-cloud
WORKDIR /usr/src/voice-cloud

COPY initdb.sql /docker-entrypoint-initdb.d/.

# Install & run bundler

COPY Gemfile /voice-cloud/Gemfile
COPY Gemfile.lock /voice-cloud/Gemfile.lock

RUN gem install bundler
RUN bundle

RUN mkdir -p tmp/sockets

CMD ./docker-entrypoint.sh
