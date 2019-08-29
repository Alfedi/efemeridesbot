defmodule Efemeridesbot.Bot do
  @bot :efemeridesbot

  use ExGram.Bot,
    name: @bot

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    execute()
  end

  def execute() do
    {:ok, %Tesla.Env{body: body}} = Efemeridesbot.Api.get(Date.utc_today.month, Date.utc_today.day)
    {:ok, %{"query" => %{"pages" => pages}}} = Jason.decode(body)
    [{_, extract} | _] = Map.to_list(pages)
    res = Map.get(extract, "extract")
    ExGram.send_message("Channel", res, parse_mode: "html")
  end

  def handle(_, _) do
    :no_reply
  end
end
