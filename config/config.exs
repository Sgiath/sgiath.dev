import Config

config :web,
  generators: [context_app: :sgiath]

# Configures the endpoint
config :web, Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Sgiath.PubSub,
  live_view: [signing_salt: "QUC+qRZg"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.47",
  default: [
    args:
      ~w(js/app.js --bundle --target=esnext --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --external:/icons/*),
    cd: Path.expand("../apps/web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
