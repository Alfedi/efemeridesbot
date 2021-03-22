FROM elixir:1.8-slim

RUN mkdir /bot
WORKDIR /bot

RUN mix local.hex --force && mix local.rebar --force
COPY . .
RUN mix deps.get
RUN mix compile

ENTRYPOINT ["/bot/start.sh"]
