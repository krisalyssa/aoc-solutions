defmodule AoC.Day01.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day01

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert AoC.Day01.part_1(["3   4", "4   3", "2   5", "1   3", "3   9", "3   3"]) == 11
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert AoC.Day01.part_2(["3   4", "4   3", "2   5", "1   3", "3   9", "3   3"]) == 31
    end
  end

  describe "distances/2" do
    test "with sample data" do
      list1 = [3, 3, 1, 2, 4, 3]
      list2 = [3, 9, 3, 5, 3, 4]
      distances = Day01.distances({list1, list2})

      refute is_nil(distances)
      assert is_list(distances)
      assert Enum.count(distances) == 6
      assert distances == [2, 1, 0, 1, 2, 5]
    end
  end

  describe "parse_lines/1" do
    test "with sample data" do
      data = [
        "3   4",
        "4   3",
        "2   5",
        "1   3",
        "3   9",
        "3   3"
      ]

      {list1, list2} = Day01.parse_lines(data)

      refute is_nil(list1)
      assert is_list(list1)
      assert Enum.count(list1) == 6
      assert list1 == [3, 3, 1, 2, 4, 3]

      refute is_nil(list2)
      assert is_list(list2)
      assert Enum.count(list2) == 6
      assert list2 == [3, 9, 3, 5, 3, 4]
    end
  end

  describe "similarity_scores/1" do
    test "with sample data" do
      list1 = [3, 3, 1, 2, 4, 3]
      list2 = [3, 9, 3, 5, 3, 4]
      scores = Day01.similarity_scores({list1, list2})

      refute is_nil(scores)
      assert is_list(scores)
      assert Enum.count(scores) == 6
      assert scores == [9, 9, 0, 0, 4, 9]
    end
  end

  describe "total_distance/1" do
    test "with sample data" do
      list = [2, 1, 0, 1, 2, 5]
      assert Day01.total_distance(list) == 11
    end
  end
end
