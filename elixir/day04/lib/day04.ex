defmodule Day04 do
  def calculate(content, startwith \\ "00000", number \\ 1) do
    base = :crypto.hash(:md5, "#{content}#{number}") |> Base.encode16
    if String.starts_with?(base, startwith) do
      number
    else
      calculate(content, startwith, number + 1)
    end
  end

  def part01() do
    File.read!("input.txt") |> String.trim
    |> calculate
  end

  def part02() do
    File.read!("input.txt") |> String.trim
    |> calculate("000000")
  end

  def main(_) do
    IO.puts "AOC 2015 Day 04"
    IO.puts "Part 1: "
    part01() |> IO.puts
    IO.puts "Part 2: "
    part02() |> IO.puts
  end
end
