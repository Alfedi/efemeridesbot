defmodule Efemeridesbot.Bot do
  @bot :efemeridesbot

  use ExGram.Bot,
    name: @bot

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Bienvenido al EfeméridesBot")
  end

  def handle({:command, "send", _msg}, context) do
    execute()
  end

  def handle(_, _) do
    :no_reply
  end

  def execute() do
    # Text
    {:ok, %{body: body}} =
      Efemeridesbot.Api.get_extract(Date.utc_today().month, Date.utc_today().day)

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
          "</p>",
          "<span>",
          "</span>"
        ],
        ""
      )

    # Image
    {:ok, %{body: bodyimg}} =
      Efemeridesbot.Api.get_image(Date.utc_today().month, Date.utc_today().day)

    {:ok, %{"query" => %{"pages" => %{"-1" => %{"imageinfo" => [%{"url" => url}]}}}}} =
      Jason.decode(bodyimg)

    # Because of the way Download works I need to remove the image before downloading another one.
    System.cmd("rm", ["photo.png"])

    Download.from(url, path: "photo.png")

    # Send message
    ExGram.send_photo("@tal_dia_como_hoy", {:file, "photo.png"}, caption: msg, parse_mode: "html")
  end
end
