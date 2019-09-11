defmodule Efemeridesbot do
  use Application

  require Logger

  def start(_, _) do
    token = ExGram.Config.get(:ex_gram, :token)

    children = [
      ExGram,
      {Efemeridesbot.Bot, [method: :polling, token: token]}
    ]

    opts = [strategy: :one_for_one, name: Efemeridesbot.Supervisor]

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
