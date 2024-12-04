defmodule AoC.Day01.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day01

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day01.part_1(["1122"]) == 3
      assert Day01.part_1(["1111"]) == 4
      assert Day01.part_1(["1234"]) == 0
      assert Day01.part_1(["91212129"]) == 9
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day01.part_2(["../data/01.txt"]) == 1
    end
  end

  describe "chunk/1" do
    test "with sample data" do
      assert Day01.chunk("1122") == [[1, 1], [1, 2], [2, 2], [2, 1]]
      assert Day01.chunk("1111") == [[1, 1], [1, 1], [1, 1], [1, 1]]
      assert Day01.chunk("1234") == [[1, 2], [2, 3], [3, 4], [4, 1]]

      assert Day01.chunk("91212129") == [
               [9, 1],
               [1, 2],
               [2, 1],
               [1, 2],
               [2, 1],
               [1, 2],
               [2, 9],
               [9, 9]
             ]
    end
  end
end
