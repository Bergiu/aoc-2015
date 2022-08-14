defmodule Day05 do
  def is_vowel?(char) do
    vowels = [?a, ?e, ?i, ?o, ?u]
    if Enum.member?(vowels, char), do: true, else: false
  end

  def count_vowels(word) do
    String.to_charlist(word)
    |> Enum.reduce(0, fn(char, count) ->
      if is_vowel?(char), do: count + 1, else: count
    end)
  end

  def vowel_condition?(word) do
    count_vowels(word) >= 3
  end

  def count_twice(word) do
    charlist = String.to_charlist(word)
    Enum.with_index(charlist)
    |> Enum.take(Enum.count(charlist) - 1)
    |> Enum.filter(fn({char, i}) ->
      Enum.at(charlist, i + 1) == char
    end)
    |> Enum.count
  end

  def twice_condition?(word) do
    count_twice(word) >= 1
  end

  def third_condition?(word) do
    String.contains?(word, ["ab", "cd", "pq", "xy"])
  end

  def nice?(word) do
    vowel_condition?(word) and twice_condition?(word) and not third_condition?(word)
  end

  def count_repeat(word) do
    charlist = String.to_charlist(word)
    Enum.with_index(charlist)
    |> Enum.take(Enum.count(charlist) - 2)
    |> Enum.filter(fn({char, i}) ->
      Enum.at(charlist, i + 2) == char
    end)
    |> Enum.count
  end

  def repeats?(word) do
    count_repeat(word) >= 1
  end

  def count_pairs(word) do
    charlist = String.to_charlist(word)
    Enum.with_index(charlist)
    |> Enum.take(Enum.count(charlist) - 1)
    |> Enum.filter(fn({char, i}) ->
      part = [char, Enum.at(charlist, i + 1)]
      |> List.to_string
      sub = String.slice(word, i+2..String.length(word))
      String.contains?(sub, part)
    end)
    |> Enum.count
  end

  def pairs?(word) do
    count_pairs(word) >= 1
  end

  def real_nice?(word) do
    pairs?(word) and repeats?(word)
  end

  def part01() do
    File.read!("input.txt")
    |> String.trim
    |> String.split("\n", [trim: true])
    |> Enum.filter(&nice?/1)
    |> Enum.count
  end

  def part02() do
    File.read!("input.txt")
    |> String.trim
    |> String.split("\n", [trim: true])
    |> Enum.filter(&real_nice?/1)
    |> Enum.count
  end

  def main(_) do
    IO.puts "AOC 2015 Day 05"
    IO.puts "Part 1: "
    part01() |> IO.puts
    IO.puts "Part 2: "
    part02() |> IO.puts
  end
end
