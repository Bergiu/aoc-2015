defmodule Day03 do
  def parse_input(content) do
    {list, _} = content
    |> String.to_charlist
    |> Enum.reduce({[{0, 0}], {0, 0}}, fn(char, {list, {x, y}}) ->
      pos = case char do
        ?< -> {x - 1, y}
        ?> -> {x + 1, y}
        ?v -> {x, y - 1}
        ?^ -> {x, y + 1}
        _ -> {x, y}
      end
      {[pos | list], pos}
    end)
    Enum.count(Enum.uniq(list))
  end

  def parse_input_next_year(content) do
    {list, _, _, _} = content
    |> String.to_charlist
    |> Enum.reduce({[{0, 0}], {0, 0}, {0, 0}, true}, fn(char, {list, santa, robo, dir}) ->
      {x, y} = if dir, do: santa, else: robo
      pos = case char do
        ?< -> {x - 1, y}
        ?> -> {x + 1, y}
        ?v -> {x, y - 1}
        ?^ -> {x, y + 1}
        _ -> {x, y}
      end
      {santa, robo} = if dir, do: {pos, robo}, else: {santa, pos}
      {[pos | list], santa, robo, not dir}
    end)
    Enum.count(Enum.uniq(list))
  end

  def part01() do
    File.read!("input.txt")
    |> parse_input
  end

  def part02() do
    File.read!("input.txt")
    |> parse_input_next_year
  end

  def main(_) do
    IO.puts "AOC 2015 Day 03"
    IO.puts "Part 1: "
    IO.inspect part01()
    IO.puts "Part 2: "
    IO.inspect part02()
  end
end
