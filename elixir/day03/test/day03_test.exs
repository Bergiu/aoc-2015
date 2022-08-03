defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "parse input" do
    assert Day03.parse_input(">") == 2
    assert Day03.parse_input("^>v<") == 4
    assert Day03.parse_input("^v^v^v^v^v") == 2
  end

  test "parse input next year" do
    assert Day03.parse_input_next_year("^v") == 3
    assert Day03.parse_input_next_year("^>v<") == 3
    assert Day03.parse_input_next_year("^v^v^v^v^v") == 11
  end
end
