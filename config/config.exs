import Config

config :web,
  generators: [context_app: :sgiath]

config :web, Web.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: Web.ErrorHTML, json: Web.ErrorJSON],
    layout: false
  ],
  pubsub_server: Sgiath.PubSub,
  live_view: [signing_salt: "QUC+qRZg"]

config :esbuild,
  version: "0.17.19",
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

config :tailwind,
  version: "3.3.2",
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
