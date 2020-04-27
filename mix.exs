defmodule PhoenixCowboyLogging.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_cowboy_logging,
     description: "Pry some information from cowboy when it fails to parse requests.",
     version: "2.0.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:cowboy, "~> 2.7"},
     {:ex_doc, "~> 0.21.3", only: :dev}]
  end

  defp package do
    [# These are the default files included in the package
     name: :phoenix_cowboy_logging,
     files: ["lib", "mix.exs", "README*"],
     maintainers: ["Peter Williams"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/pezra/phoenix_cowboy_logging"}]
  end
end
