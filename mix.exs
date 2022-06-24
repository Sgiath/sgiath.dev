defmodule Sgiath.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        release: :prod,
        deploy: :prod
      ],

      # Releases
      releases: [
        sgiath: [
          path: "release",
          steps: [&assets/1, :assemble, :tar],
          include_executables_for: [:unix],
          applications: [
            sgiath: :permanent,
            web: :permanent
          ]
        ]
      ]
    ]
  end

  defp deps do
    []
  end

  defp aliases do
    [
      setup: ["cmd mix setup"],
      deploy: &deploy/1
    ]
  end

  defp assets(release) do
    Mix.Task.run("cmd", ["--app", "web", "mix assets.deploy"])
    release
  end

  defp deploy(_args) do
    Mix.shell().cmd("git reset --hard")
    Mix.Task.run("setup")
    Mix.Task.run("release")
    Mix.shell().cmd("./release/bin/sgiath restart")
  end
end
