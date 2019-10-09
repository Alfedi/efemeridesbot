defmodule Efemeridesbot.Bot do
  @bot :efemeridesbot

  use ExGram.Bot,
    name: @bot

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Bienvenido al EfeméridesBot")
  end

  def handle(_, _) do
    :no_reply
  end

  def execute() do
    {:ok, %Tesla.Env{body: body}} =
      Efemeridesbot.Api.get(Date.utc_today().month, Date.utc_today().day)

    {:ok, %{"query" => %{"pages" => pages}}} = Jason.decode(body)
    [{_, extract} | _] = Map.to_list(pages)
    res = Map.get(extract, "extract")

    msg =
      String.replace(
        res,
        [
          "<ul>",
          "</ul>",
          "<li>",
          "</li>",
          "<i>",
          "</i>",
          "<br>",
          "</br>",
          "<p>",
          "</p>"
        ],
        ""
      )

    ExGram.send_message("@tal_dia_como_hoy", msg, parse_mode: "html")
  end
end
