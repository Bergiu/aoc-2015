defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "overlapping?" do
    assert Day06.overlapping?({0,0}, {5,5}, false, {{0,0}, {10,10}, true}) == true
    assert Day06.overlapping?({0,0}, {5,5}, false, {{6,6}, {10,10}, true}) == false
    assert Day06.overlapping?({0,0}, {10,10}, false, {{6,6}, {7,7}, true}) == true
    assert Day06.overlapping?({8,8}, {10,10}, false, {{6,6}, {7,7}, true}) == false
    assert Day06.overlapping?({0,0}, {0,10}, false, {{0,0}, {10,0}, true}) == true
    assert Day06.overlapping?({0,0}, {5,5}, false, {{5,5}, {10,10}, true}) == true
    assert Day06.overlapping?({10,10}, {20,20}, false, {{0,15}, {30,15}, true}) == true
    assert Day06.overlapping?({10,10}, {20,20}, false, {{0,15}, {15,15}, true}) == true
    assert Day06.overlapping?({10,10}, {20,20}, false, {{0,15}, {15,15}, false}) == false
    assert Day06.overlapping?({10,10}, {20,20}, true, {{0,15}, {15,15}, true}) == false
  end

  test "split x" do
    assert Day06.split_x({5,0}, {8,0}, false, {{0,0}, {10,0}, true}) == [{{0,0},{4,0},true},{{5,0},{8,0},false},{{9,0},{10,0},true}]
    assert Day06.split_x({0,0}, {10,0}, false, {{5,0}, {8,0}, true}) == [{{5,0},{8,0}, false}]
    assert Day06.split_x({0,0}, {0,0}, false, {{0,0}, {0,0}, true}) == [{{0,0}, {0,0}, false}]
    assert Day06.split_x({0,0}, {1,0}, false, {{1,0}, {1,0}, true}) == [{{1,0}, {1,0}, false}]
    assert Day06.split_x({1,0}, {2,0}, false, {{1,0}, {1,0}, true}) == [{{1,0}, {1,0}, false}]
  end

  test "split y" do
    assert Day06.split_y({0,5}, {0,8}, false, {{0,0}, {0,10}, true}) == [{{0,0},{0,4},true},{{0,5},{0,8},false},{{0,9},{0,10},true}]
    assert Day06.split_y({0,0}, {0,10}, false, {{0,5}, {0,8}, true}) == [{{0,5},{0,8}, false}]
    assert Day06.split_y({0,0}, {0,0}, false, {{0,0}, {0,0}, true}) == [{{0,0}, {0,0}, false}]
    assert Day06.split_y({0,0}, {0,1}, false, {{0,1}, {0,1}, true}) == [{{0,1}, {0,1}, false}]
    assert Day06.split_y({0,1}, {0,2}, false, {{0,1}, {0,1}, true}) == [{{0,1}, {0,1}, false}]
  end

  test "split" do
    assert Day06.split({5,0}, {8,0}, false, {{0,0}, {10,0}, true}) == [{{0,0},{4,0},true},{{5,0},{8,0},false},{{9,0},{10,0},true}]
    assert Day06.split({0,0}, {10,0}, false, {{5,0}, {8,0}, true}) == [{{5,0},{8,0}, false}]
    assert Day06.split({0,0}, {0,0}, false, {{0,0}, {0,0}, true}) == [{{0,0}, {0,0}, false}]
    assert Day06.split({0,0}, {1,0}, false, {{1,0}, {1,0}, true}) == [{{1,0}, {1,0}, false}]
    assert Day06.split({1,0}, {2,0}, false, {{1,0}, {1,0}, true}) == [{{1,0}, {1,0}, false}]
    assert Day06.split({0,0}, {0,10}, false, {{0,5}, {0,8}, true}) == [{{0,5},{0,8}, false}]
    assert Day06.split({0,0}, {0,0}, false, {{0,0}, {0,0}, true}) == [{{0,0}, {0,0}, false}]
    assert Day06.split({0,0}, {0,1}, false, {{0,1}, {0,1}, true}) == [{{0,1}, {0,1}, false}]
    assert Day06.split({0,1}, {0,2}, false, {{0,1}, {0,1}, true}) == [{{0,1}, {0,1}, false}]
    assert Day06.split({0,5}, {0,8}, false, {{0,0}, {0,10}, true}) == [{{0,0},{0,4},true},{{0,5},{0,8},false},{{0,9},{0,10},true}]
  end
end
