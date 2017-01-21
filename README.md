# PhoenixCowboyLogging

Add logging of request acceptance and parse errors that happen at the cowboy level to your Phoenix app.

## Usage

You must call `PhoenixCowboyLogging.enable_for/2` before starting you Phoenix endpoint. This generally means adding it early in the application's `start` function. For example:

```elixir
defmodule MyWebApp do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    PhoenixCowboyLogging.enable_for(:my_web_app, __MODULE__.Endpoint)

    children = [
      supervisor(__MODULE__.Endpoint, []),
...
```


## Installation

This package can be installed as:

  1. Add `phoenix_cowboy_logging` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:phoenix_cowboy_logging, "~> 1.0"}]
    end
    ```

