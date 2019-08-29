defmodule Efemeridesbot do
  use Application

  require Logger

  def start(_, _) do
    token = ExGram.Config.get(:efemeridesbot, :token)

    children = [
      ExGram,
      {Efemeridesbot.Bot, [method: :polling, token: token]}
    ]

    opts = [strategy: :one_for_one, name: Efemeridesbot]

    case Supervisor.start_link(children, opts) do
      {:ok, _} = ok ->
        Logger.info("Starting bot")
        ok

      error ->
        Logger.error("Something went wrong")
        error
    end
  end
end
