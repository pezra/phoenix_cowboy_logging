defmodule PhoenixCowboyLogging.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_cowboy_logging,
     version: "1.0.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:cowboy, "~> 1.0"}]
  end
end
