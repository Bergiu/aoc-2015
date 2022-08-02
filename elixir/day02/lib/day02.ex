defmodule Box do
  @enforce_keys [:l, :w, :h]
  defstruct [:l, :w, :h]

  def calc_paper(box) do
    sides = [box.l * box.w, box.w * box.h, box.h * box.l]
    Enum.min(sides) + Enum.sum(Enum.map(sides, & (&1 * 2)))
  end

  def calc_ribbon(box) do
    vals = Enum.drop(Map.values(box), 1)  # [l, w, h]
    mins = List.delete(vals, Enum.max(vals))  # the two minimum values
    Enum.sum(mins) * 2 + Enum.product(vals)
  end
end


defmodule Day02 do
  def parse_input(input) do
    input
    |> String.split("\n", [trim: true])
    |> Enum.map(fn (line) ->
      String.split(line, "x")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def calculate_wrapping_paper(content) do
    Enum.map(content, fn (line) ->
      %Box{l: Enum.at(line, 0), w: Enum.at(line, 1), h: Enum.at(line, 2)}
      |> Box.calc_paper
    end)
    |> Enum.sum
  end

  def calculate_ribbon(content) do
    Enum.map(content, fn (line) ->
      %Box{l: Enum.at(line, 0), w: Enum.at(line, 1), h: Enum.at(line, 2)}
      |> Box.calc_ribbon
    end)
    |> Enum.sum
  end

  def part01() do
    File.read!("input.txt")
    |> parse_input
    |> calculate_wrapping_paper
  end

  def part02() do
    File.read!("input.txt")
    |> parse_input
    |> calculate_ribbon
  end

  def main(_) do
    IO.puts "AOC 2015 Day 01"
    IO.puts "Part 1: "
    IO.inspect part01()
    IO.puts "Part 2: "
    IO.inspect part02()
  end
end
