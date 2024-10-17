ARG ELIXIR_VERSION=1.17.3
ARG OTP_VERSION=27.0.1
ARG ALPINE_VERSION=3.20.3

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION}"
ARG RUNNER_IMAGE="alpine:${DEBIAN_VERSION}"

# =================================================================================================
# Build phase
# =================================================================================================
FROM ${BUILDER_IMAGE} as builder

# setup env
ENV MIX_ENV=prod

# install build dependencies
RUN apk update && apk --no-cache --update add build-base git nodejs npm

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only ${MIX_ENV}

# copy relevant configuration
RUN mkdir config
COPY config/config.exs config/${MIX_ENV}.exs config/

# compile dependencies
RUN mix deps.compile

# copy files needed for compiling assets
COPY priv/ priv/
COPY lib/ lib/
COPY assets/ assets/
RUN mix assets.deploy

# compile
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

RUN mix release --path ./release

# =================================================================================================
# Runtime phase
# =================================================================================================
FROM ${RUNNER_IMAGE}

# install runtime packages
RUN apk add --no-cache --update libstdc++ openssl

# delete APK cache
RUN rm -rf /var/cache/apk/*

# setup workdir
WORKDIR /app
RUN chown nobody /app

# read the MIX_ENV
ENV MIX_ENV=prod

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/release .

USER nobody
EXPOSE 4000

CMD ["/app/bin/default", "start"]
