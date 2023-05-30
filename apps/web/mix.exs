defmodule Web.MixProject do
  use Mix.Project

  def project do
    [
      # Application config
      app: :web,
      version: "0.1.0",
      elixir: "~> 1.14",

      # Elixir config
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Umbrella paths
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock"
    ]
  end

  def application do
    [
      mod: {Web.Application, []},
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

      # Development
      {:phoenix_live_reload, "~> 1.4", only: :dev}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": [
        "tailwind default --minify",
        "phx.digest"
      ]
    ]
  end
end
