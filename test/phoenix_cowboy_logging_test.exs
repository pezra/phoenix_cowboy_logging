defmodule PhoenixCowboyLoggingTest do
  use ExUnit.Case
  doctest PhoenixCowboyLogging

  test "enable_for/2 with http" do
    Application.put_env(:test_app, __MODULE__, [http: []])

    PhoenixCowboyLogging.enable_for(:test_app, __MODULE__)

    assert is_function(Kernel.get_in(Application.get_env(:test_app, __MODULE__),
        [:http, :protocol_options, :onresponse]))
    assert is_nil(Kernel.get_in(Application.get_env(:test_app, __MODULE__),
        [:https, :protocol_options, :onresponse]))
  end

  test "enable_for/2 with https" do
    Application.put_env(:test_app, __MODULE__, [https: []])

    PhoenixCowboyLogging.enable_for(:test_app, __MODULE__)

    assert is_function(Kernel.get_in(Application.get_env(:test_app, __MODULE__),
        [:https, :protocol_options, :onresponse]))
    assert is_nil(Kernel.get_in(Application.get_env(:test_app, __MODULE__),
        [:http, :protocol_options, :onresponse]))
  end

  test "enable_for/2 with http and https" do
    Application.put_env(:test_app, __MODULE__, [http: [], https: []])

    PhoenixCowboyLogging.enable_for(:test_app, __MODULE__)

    assert is_function(Kernel.get_in(Application.get_env(:test_app, __MODULE__),
        [:https, :protocol_options, :onresponse]))
    assert is_function(Kernel.get_in(Application.get_env(:test_app, __MODULE__),
        [:http, :protocol_options, :onresponse]))
  end
end
