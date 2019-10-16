defmodule Efemeridesbot.Api do
  use Tesla

  def client() do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "https://es.wikipedia.org"}
    ]

    Tesla.client(middlewares)
  end

  def get_extract(month_n, day) do
    month = month_convert(month_n)

    Tesla.get(client(), "/w/api.php",
      query: [
        format: "json",
        action: "query",
        prop: "extracts",
        redirects: 1,
        titles: "Plantilla:Efemérides_-_#{day}_de_#{month}"
      ]
    )
  end

  def get_image(month_n, day) do
    month = month_convert(month_n)

    Tesla.get(client(), "/w/api.php",
      query: [
        format: "json",
        action: "query",
        generator: "images",
        prop: "imageinfo",
        iiprop: "url",
        titles: "Plantilla:Efemérides_-_#{day}_de_#{month}"
      ]
    )
  end

  def month_convert(num) do
    map = %{
      1 => "enero",
      2 => "febrero",
      3 => "marzo",
      4 => "abril",
      5 => "mayo",
      6 => "junio",
      7 => "julio",
      8 => "agosto",
      9 => "septiembre",
      10 => "octubre",
      11 => "noviembre",
      12 => "diciembre"
    }

    Map.get(map, num)
  end
end
