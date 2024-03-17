defmodule Frontend.MixProject do
  use Mix.Project

  def project do
    [
      app: :frontend,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Frontend.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:bandit, "~> 1.0"},
      {:req, "~> 0.4.0"},
    ]
  end
end
