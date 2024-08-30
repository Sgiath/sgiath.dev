ARG ELIXIR_VERSION=1.17.2
ARG OTP_VERSION=27.0.1
ARG DEBIAN_VERSION=bookworm-20240812-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

# =================================================================================================
# Build phase
# =================================================================================================
FROM ${BUILDER_IMAGE} as builder

# setup env
ENV MIX_ENV=prod

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

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

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

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
