defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "Box calc paper" do
    assert %Box{l: 2, w: 3, h: 4} |> Box.calc_paper == 58
    assert %Box{l: 1, w: 1, h: 10} |> Box.calc_paper == 43
  end

  test "Box calc ribbon" do
    assert %Box{l: 2, w: 3, h: 4} |> Box.calc_ribbon == 34
    assert %Box{l: 1, w: 1, h: 10} |> Box.calc_ribbon == 14
  end

  test "Calc wrapping paper" do
    assert Day02.calculate_wrapping_paper([[2,3,4], [1,1,10]]) == 58 + 43
  end
end
