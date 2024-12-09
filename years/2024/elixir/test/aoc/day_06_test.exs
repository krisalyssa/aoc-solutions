defmodule AoC.Day06.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day06
  alias AoC.Day06.State

  # comment this out to always log to the console
  @moduletag :capture_log

  @sample_data [
    "....#.....",
    ".........#",
    "..........",
    "..#.......",
    ".......#..",
    "..........",
    ".#..^.....",
    "........#.",
    "#.........",
    "......#..."
  ]

  describe "part 1" do
    test "with sample data" do
      assert Day06.part_1(@sample_data) == 41
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day06.part_2(["../data/06.txt"]) == 1
    end
  end

  describe "load_grid/1" do
    test "with sample data" do
      assert Day06.load_grid(@sample_data) ==
               {[
                  ~c"....#.....",
                  ~c".........#",
                  ~c"..........",
                  ~c"..#.......",
                  ~c".......#..",
                  ~c"..........",
                  ~c".#........",
                  ~c"........#.",
                  ~c"#.........",
                  ~c"......#..."
                ], %State{index: {6, 4}, heading: :north}}
    end
  end

  describe "step/1" do
    test "forward step" do
      {grid, state} = Day06.load_grid(@sample_data)

      assert Day06.step({grid, state}) ==
               {[
                  ~c"....#.....",
                  ~c".........#",
                  ~c"..........",
                  ~c"..#.......",
                  ~c".......#..",
                  ~c"....^.....",
                  ~c".#..X.....",
                  ~c"........#.",
                  ~c"#.........",
                  ~c"......#..."
                ], %State{index: {5, 4}, heading: :north}}
    end

    test "rotated step" do
      {grid, _} = Day06.load_grid(@sample_data)

      assert Day06.step({grid, %State{index: {1, 4}, heading: :north}}) ==
               {[
                  ~c"....#.....",
                  ~c"....X>...#",
                  ~c"..........",
                  ~c"..#.......",
                  ~c".......#..",
                  ~c"..........",
                  ~c".#........",
                  ~c"........#.",
                  ~c"#.........",
                  ~c"......#..."
                ], %State{index: {1, 5}, heading: :east}}
    end

    test "exiting step" do
      {grid, _} = Day06.load_grid(@sample_data)

      assert Day06.step({grid, %State{index: {9, 7}, heading: :south}}) ==
               {[
                  ~c"....#.....",
                  ~c".........#",
                  ~c"..........",
                  ~c"..#.......",
                  ~c".......#..",
                  ~c"..........",
                  ~c".#........",
                  ~c"........#.",
                  ~c"#.........",
                  ~c"......#X.."
                ], %State{index: {10, 7}, heading: :exited}}
    end
  end

  describe "walk/1" do
    test "with sample data" do
      {grid, state} = Day06.load_grid(@sample_data)

      assert Day06.walk({grid, state}) ==
               {[
                  ~c"....#.....",
                  ~c"....XXXXX#",
                  ~c"....X...X.",
                  ~c"..#.X...X.",
                  ~c"..XXXXX#X.",
                  ~c"..X.X.X.X.",
                  ~c".#XXXXXXX.",
                  ~c".XXXXXXX#.",
                  ~c"#XXXXXXX..",
                  ~c"......#X.."
                ], %State{index: {10, 7}, heading: :exited}}
    end
  end
end
