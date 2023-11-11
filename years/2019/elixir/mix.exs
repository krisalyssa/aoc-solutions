defmodule AoC.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "2019.0.1",
      elixir: "~> 1.9",
      elixirc_options: [warnings_as_errors: true],
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [espec: :test],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      # test: ["format", "credo --strict", "dialyzer", "espec"]
      test: ["espec"]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:espec, "~> 1.9", only: [:test]},
      {:exprintf, "~> 0.2.1"},
      {:libgraph, "~> 0.16.0"},
      {:math, git: "https://github.com/CraigCottingham/math.git"},
      {:max, "~> 0.1.3"},
      {:mix_test_watch, "~> 1.1", only: :dev, runtime: false}
    ]
  end
end
