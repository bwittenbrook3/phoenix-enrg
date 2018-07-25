# build image
FROM elixir:1.6.6-alpine as build

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

# run stage
FROM elixir:1.6.6-alpine

RUN apk add --update \
    nodejs \
    bash \
    git

RUN mix local.hex --force && \
    mix local.rebar --force

# add entrypoint script
RUN mkdir /app
WORKDIR /app
COPY entrypoint.sh ./

# setup the /api application
RUN mkdir -p api
WORKDIR /app/api
ENV REPLACE_OS_VARS true
COPY --from=build /app/_build/prod/rel/api .


WORKDIR /app
EXPOSE 80
CMD ["./entrypoint.sh"]
