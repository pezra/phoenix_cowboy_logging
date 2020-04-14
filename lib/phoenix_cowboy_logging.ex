defmodule PhoenixCowboyLogging do
  @moduledoc """

  Adds some logging to Cowboy so that we see *something* if cowboy rejects a
  request while accepting or parsing it.

  When cowboy fails to parse an request it calls `onreponse/4` with a completely
  bogus request. Nothing about it should be trusted.

  """

  require Logger

  @doc """
  Adds the settings needed to enable the logging. This much be called *before*
  starting the Phoenix endpoint so it should be called early in every Phoenix
  application's `start` function.
  """
  def enable_for(otp_app, key) do
    new_config =
      Application.get_env(otp_app, key)
      |> maybe_add_on_response(:http)
      |> maybe_add_on_response(:https)

    Application.put_env(otp_app, key, new_config)
  end

  @doc """
  Callback that does the logging.
  """
  def onresponse(status_code, _headers, _body, request) do
    with {url, _} <- :cowboy_req.uri(request),
         {method, _} <- :cowboy_req.method(request)
    do
      if probably_cowboy_error?(status_code, request) do
        Logger.error  "It looks like cowboy failed to accept or parse a request. Unfortunately, cowboys are notoriously non-communicative so that is pretty much all we can tell you about what went wrong. Sorry."
        Logger.error "Completed UNKNOWN REQUEST (cowboy failure) with #{status_code}"
      else
        Logger.info "Completed #{method} <#{url}> with #{status_code}"
      end
    end

    request
  end

  # private

  defp probably_cowboy_error?(status, request) do
    failure?(status) && missing_headers?(request)
  end

  defp failure?(status) do
    status >= 400
  end

  defp missing_headers?(request) do
    {req_headers, _ } = :cowboy_req.headers(request)

    [] == req_headers
  end

  defp maybe_add_on_response(config, proto) do
    with true <- Keyword.has_key?(config, proto),
         {_, config} <- put_default_in(config, [proto, :protocol_options], [])
    do
      Kernel.put_in(config, [proto, :protocol_options, :onresponse],
        &__MODULE__.onresponse/4)
    else
      _ -> config
    end
  end

  defp put_default_in(container, keys, default_val) do
    Kernel.get_and_update_in(container, keys, fn val ->
      if val == nil do
        {default_val, default_val}
      else
        {val, val}
      end
    end)
  end
end
