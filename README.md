# PhoenixCowboyLogging

Add logging of request acceptance and parse errors that happen at the cowboy level to your Phoenix app.

## Usage

You must call `PhoenixCowboyLogging.enable_for/2` before starting you Phoenix endpoint. This generally means adding it early in the application's `start` function. For example:

```elixir
defmodule MyWebApp do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    PhoenixCowboyLogging.enable_for(:ic_web, IcWeb.Endpoint)

    children = [
      supervisor(MyWebApp.Endpoint, []),
...
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `phoenix_cowboy_logging` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:phoenix_cowboy_logging, "~> 0.1.0"}]
    end
    ```

