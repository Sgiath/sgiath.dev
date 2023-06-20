defmodule Sgiath.MixProject do
  use Mix.Project

  def project do
    [
      # Application config
      app: :sgiath,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        release: :prod,
        deploy: :prod
      ],

      # Releases
      releases: [
        default: [
          include_executables_for: [:unix],
          applications: [
            sgiath: :permanent
          ]
        ]
      ]
    ]
  end

  def application do
    [
      mod: {Sgiath.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.7"},
      {:phoenix_pubsub, "~> 2.1"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.19"},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:jason, "~> 1.4"},
      {:bandit, "~> 0.7"},
      {:saxy, "~> 1.5"},

      # Development
      {:phoenix_live_reload, "~> 1.4", only: :dev},
      {:ex_check, "~> 0.15", only: :dev}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": [  "tailwind default --minify",  "phx.digest"]
    ]
  end
end
