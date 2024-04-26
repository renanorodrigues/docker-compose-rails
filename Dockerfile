FROM ruby:3.1.4 AS base

ENV INSTALL_PATH /app

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install 

FROM base

WORKDIR $INSTALL_PATH

COPY . $INSTALL_PATH

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD ["rails", "server", "-b", "0.0.0.0"]
