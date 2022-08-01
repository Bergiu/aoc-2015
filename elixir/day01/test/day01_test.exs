defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "calculate floor" do
    assert Day01.calculate_floor("((()") == 2
  end

  test "read file" do
    assert Day01.read_file("input_test.txt") == "(((())"
  end

  test "pos of basement" do
    assert Day01.pos_of_basement(")") == 1
    # assert Day01.pos_of_basement("()())") == 5
  end
end
