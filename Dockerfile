FROM node:11.12.0 as node
FROM ruby:2.6.6

ENV LANG C.UTF-8
ENV BUILD_PACKAGES="ruby-dev bash" \
    DEV_PACKAGES="libxml2-dev libxslt-dev tzdata" \
    RUBY_PACKAGES="ruby-json nodejs"

RUN apt-get update -qq -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    wget \
    ca-certificates \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES \
    libfontconfig1 && \
    rm -rf /var/lib/apt/lists/*

ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink


ENV YARN_VERSION 1.15.2

COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/

RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

ENV BUNDLE_JOBS=4 \
    APP_DIR=/app/ \
    BUNDLE_PATH=/bundle/

RUN mkdir $APP_DIR

WORKDIR $APP_DIR

COPY ./Gemfile $APP_DIR
COPY ./Gemfile.lock $APP_DIR
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --no-deployment --quiet --path /bundle
RUN yarn install --check-files
COPY ./ $APP_DIR

CMD [ \
    "prehook", "rm /app/tmp/pids/server.pid" \
    "prehook", "ruby -v", "--", \
    "prehook", "bundle install -j3 --quiet --path /bundle", "--"]