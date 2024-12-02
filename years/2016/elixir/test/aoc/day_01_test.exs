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
      assert Day01.part_2(["../data/01.txt"]) == 1
    end
  end

  describe "distance/1" do
    test "with sample data" do
      assert Day01.distance({2, 3}) == 5
      assert Day01.distance({0, -2}) == 2
    end
  end

  describe "move/3" do
    test "with sample data" do
      assert Day01.move({0, 0}, :east, "2") == {2, 0}
      assert Day01.move({2, 0}, :north, "3") == {2, 3}
    end
  end
end
