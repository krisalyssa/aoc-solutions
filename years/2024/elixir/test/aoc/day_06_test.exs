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
      {grid, state} = Day06.load_grid(@sample_data)

      assert grid == [
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
             ]

      assert state.index == {6, 4}
      assert state.heading == :north
    end
  end

  describe "step/1" do
    test "forward step" do
      {grid, state} = Day06.load_grid(@sample_data)
      {grid_after, state_after} = Day06.step({grid, state})

      assert grid_after == [
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
             ]

      assert state_after.index == {5, 4}
      assert state_after.heading == :north
    end

    test "rotated step" do
      {grid, _} = Day06.load_grid(@sample_data)
      state = %State{index: {1, 4}, heading: :north}
      {grid_after, state_after} = Day06.step({grid, state})

      assert grid_after == [
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
             ]

      assert state_after.index == {1, 5}
      assert state_after.heading == :east
    end

    test "exiting step" do
      {grid, _} = Day06.load_grid(@sample_data)
      state = %State{index: {9, 7}, heading: :south}
      {grid_after, state_after} = Day06.step({grid, state})

      assert grid_after == [
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
             ]

      assert state_after.index == {10, 7}
      assert state_after.heading == :exited
    end
  end

  describe "walk/1" do
    test "with sample data" do
      {grid, state} = Day06.load_grid(@sample_data)
      {grid_after, state_after} = Day06.walk({grid, state})

      assert grid_after == [
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
             ]

      assert state_after.index == {10, 7}
      assert state_after.heading == :exited
    end
  end
end
