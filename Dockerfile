# build elixir
FROM elixir:1.6.6-alpine as elixir-build

# install build dependencies
RUN apk add --update git

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY api/mix.exs api/mix.lock ./
COPY api/config ./

RUN mix deps.get
RUN mix deps.compile


ENV SECRET_KEY_BASE `openssl rand -hex 64`

# build release
COPY api .
RUN mix release --no-tar --verbose

# build node
FROM node:8.11.3-alpine as node-build
RUN apk add --update yarn

RUN mkdir /app
WORKDIR /app
COPY web/package.json web/yarn.lock ./
RUN yarn

COPY web .
RUN yarn build

# run stage
FROM elixir:1.6.6-alpine

RUN apk add --update \
    bash \
    git \
    nginx \
    nodejs \
    nodejs-npm

RUN  npm install -g foreman

RUN mix local.hex --force && \
    mix local.rebar --force

# add Procfile
RUN mkdir /app
WORKDIR /app
COPY Procfile.prod ./Procfile
COPY entrypoint.sh ./

# setup nginx
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/nginx.conf

# setup the api application
RUN mkdir api
WORKDIR /app/api
ENV REPLACE_OS_VARS true
COPY --from=elixir-build /app/_build/prod/rel/api .

# setup the web application
WORKDIR /app
RUN mkdir web
WORKDIR /app/web
COPY --from=node-build /app .

WORKDIR /app
CMD ["./entrypoint.sh"]
