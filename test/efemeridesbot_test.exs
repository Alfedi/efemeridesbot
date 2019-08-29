defmodule EfemeridesbotTest do
  use ExUnit.Case
  doctest Efemeridesbot

  test "greets the world" do
    assert Efemeridesbot.hello() == :world
  end
end
