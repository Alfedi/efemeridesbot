defmodule Efemeridesbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :efemeridesbot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Efemeridesbot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_gram, github: "rockneurotiko/ex_gram", branch: "master"},
      {:jason, ">= 1.0.0"},
      {:tesla, "~> 1.2.1"}
    ]
  end
end
