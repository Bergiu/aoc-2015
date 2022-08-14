defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  test "count vowels" do
    assert Day05.count_vowels("aei") == 3
    assert Day05.count_vowels("xazegov") == 3
    assert Day05.count_vowels("aeiouaeiouaeiou") == 15
  end

  test "vowel condition" do
    assert Day05.vowel_condition?("aei") == true
    assert Day05.vowel_condition?("xazegov") == true
    assert Day05.vowel_condition?("aeiouaeiouaeiou") == true
    assert Day05.vowel_condition?("abcde") == false
    assert Day05.vowel_condition?("aaa") == true
  end

  test "count twice" do
    assert Day05.count_twice("xx") == 1
    assert Day05.count_twice("abcdde") == 1
    assert Day05.count_twice("aabbccdd") == 4
  end

  test "twice condition" do
    assert Day05.twice_condition?("xx") == true
    assert Day05.twice_condition?("abcdde") == true
    assert Day05.twice_condition?("aabbccdd") == true
    assert Day05.twice_condition?("abcde") == false
    assert Day05.twice_condition?("ababa") == false
    assert Day05.twice_condition?("aaa") == true
  end

  test "third condition" do
    assert Day05.third_condition?("absolut") == true
    assert Day05.third_condition?("cdplayer") == true
    assert Day05.third_condition?("apqal") == true
    assert Day05.third_condition?("lsxyz") == true
    assert Day05.third_condition?("ahtje") == false
  end

  test "is nice" do
    assert Day05.nice?("ugknbfddgicrmopn") == true
    assert Day05.nice?("aaa") == true
    assert Day05.nice?("jchzalrnumimnmhp") == false
    assert Day05.nice?("haegwjzuvuyypxyu") == false
    assert Day05.nice?("dvszwmarrgswjxmb") == false
  end

  test "count repeat" do
    assert Day05.count_repeat("xyx") == 1
    assert Day05.count_repeat("abcdefeghi") == 1
    assert Day05.count_repeat("aaa") == 1
  end

  test "repeats" do
    assert Day05.repeats?("xyx") == true
    assert Day05.repeats?("abcdefeghi") == true
    assert Day05.repeats?("aaa") == true
    assert Day05.repeats?("abca") == false
  end

  test "count pairs" do
    assert Day05.count_pairs("xyxy") == 1
    assert Day05.count_pairs("aabcdefgaa") == 1
    assert Day05.count_pairs("aaa") == 0
    assert Day05.count_pairs("aaaa") == 1
    assert Day05.count_pairs("aaaaaa") == 3
  end

  test "pairs" do
    assert Day05.pairs?("xyxy") == true
    assert Day05.pairs?("aabcdefgaa") == true
    assert Day05.pairs?("aaa") == false
    assert Day05.pairs?("aaaa") == true
    assert Day05.pairs?("aaaaaa") == true
  end

  test "real nice" do
    assert Day05.real_nice?("qjhvhtzxzqqjkmpb") == true
    assert Day05.real_nice?("xxyxx") == true
    assert Day05.real_nice?("uurcxstgmygtbstg") == false
    assert Day05.real_nice?("ieodomkazucvgmuy") == false
  end
end
