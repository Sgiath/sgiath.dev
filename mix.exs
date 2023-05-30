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
          steps: [&assets/1, :assemble, :tar, &upload/1],
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
    [
      # Required to run "mix format" on ~H/.heex files from the umbrella root
      {:phoenix_live_view, "~> 0.18", override: true}
    ]
  end

  defp aliases do
    [
      setup: ["cmd mix setup"]
    ]
  end

  defp assets(release) do
    Mix.Task.run("cmd", ["--app", "web", "mix assets.deploy"])
    release
  end

  defp upload(release) do
    dest = "/data/sgiath.dev"
    name = "#{release.name}-#{release.version}.tar.gz"
    Mix.shell().cmd("scp #{release.path}/#{name} sgiath.dev:#{dest}")
    Mix.shell().cmd("ssh sgiath.dev 'cd #{dest} && tar zxvf #{name}'")
    Mix.shell().cmd("ssh sgiath.dev 'sudo systemctl restart sgiath-web.service'")
    release
  end
end
