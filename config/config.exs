import Config

config :web,
  generators: [context_app: :sgiath]

# Configures the endpoint
config :web, Web.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: Web.ErrorHTML, json: Web.ErrorJSON],
    layout: false
  ],
  pubsub_server: Sgiath.PubSub,
  live_view: [signing_salt: "QUC+qRZg"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.16.6",
  default: [
    args: ~w(
        js/app.js
        --bundle
        --target=esnext
        --outdir=../priv/static/assets
        --external:/fonts/*
        --external:/images/*
        --external:/icons/*),
    cd: Path.expand("../apps/web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
