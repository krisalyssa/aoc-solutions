defmodule AoC.Day01.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day01

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day01.part_1(["R2, L3"]) == 5
      assert Day01.part_1(["R2, R2, R2"]) == 2
      assert Day01.part_1(["R5, L5, R5, R3"]) == 12
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day01.part_2(["R8, R4, R4, R8"]) == 4
    end
  end

  describe "distance/1" do
    test "with sample data" do
      assert Day01.distance({2, 3}) == 5
      assert Day01.distance({0, -2}) == 2
    end
  end

  describe "expand/2" do
    test "with sample data" do
      assert Day01.expand("L", "4") == ["L", ["S", "S", "S", "S"]]
    end
  end

  describe "walk/3" do
    test "with sample data" do
      assert Day01.walk(:east, {0, 0}, "2") == {2, 0}
      assert Day01.walk(:north, {2, 0}, "3") == {2, 3}
    end
  end
end
