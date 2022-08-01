defmodule Day01 do
  def read_file(filename) do
    {:ok, body} = File.read(filename)
    body |> String.trim
  end

  def calculate_floor(content) do
    content |> String.to_charlist
    |> Enum.reduce(0, fn(char, accumulator) ->
      accumulator + if char == ?(, do: 1, else: -1
    end)
  end

  def pos_of_basement(content) do
    {_, first_basement, _} = content |> String.to_charlist
    |> Enum.reduce({0, 0, 0}, fn(char, {floor, first_basement, pos}) ->
      floor = floor + if char == ?(, do: 1, else: -1
      first_basement = if floor < 0 and first_basement == 0, do: pos + 1, else: first_basement
      {floor, first_basement, pos + 1}
    end)
    first_basement
  end

  def part01 do
    content = read_file("input.txt")
    calculate_floor(content)
  end

  def part02 do
    content = read_file("input.txt")
    pos_of_basement(content)
  end

  def main(_) do
    IO.puts "AOC 2015 Day 01"
    IO.puts "Part 1: "
    part01() |> IO.puts
    IO.puts "Part 2: "
    part02() |> IO.puts
  end
end
