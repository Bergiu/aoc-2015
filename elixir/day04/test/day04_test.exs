defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  test "greets the world" do
    assert Day04.calculate("abcdef") == 609043
    assert Day04.calculate("pqrstuv") == 1048970
  end
end
