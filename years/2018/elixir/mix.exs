defmodule AoC.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_options: [warnings_as_errors: true],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:exprintf, "~> 0.2.1"},
      {:libgraph, "~> 0.16.0"},
      {:math, git: "https://github.com/krisalyssa/math.git"},
      {:matrix_reloaded, "~> 2.3"},
      {:max, "~> 0.1.3"},
      {:mix_test_watch, "~> 1.2", only: :dev, runtime: false}
    ]
  end
end
