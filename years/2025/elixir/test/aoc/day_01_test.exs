defmodule AoC.Day01.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day01

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      data = [
        "L68",
        "L30",
        "R48",
        "L5",
        "R60",
        "L55",
        "L1",
        "L99",
        "R14",
        "L82"
      ]

      assert Day01.part_1(data) == 3
    end
  end

  describe "part 2" do
    test "with sample data" do
      data = [
        "L68",
        "L30",
        "R48",
        "L5",
        "R60",
        "L55",
        "L1",
        "L99",
        "R14",
        "L82"
      ]

      assert Day01.part_2(data) == 10
    end
  end

  describe "parse_instruction/1" do
    test "with sample data" do
      assert Day01.parse_instruction("L68") == {:ok, {:left, 68}}
      assert Day01.parse_instruction("R5") == {:ok, {:right, 5}}
      assert Day01.parse_instruction("") == {:error, ""}
    end
  end

  describe "spin/2" do
    test "with sample data" do
      assert Day01.spin({:ok, {:right, 8}}, {11, 0}) == {19, 0}
      assert Day01.spin({:ok, {:left, 19}}, {19, 0}) == {0, 1}
    end
  end
end
