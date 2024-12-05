defmodule AoC.Day02.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day02

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day02.part_1(["2x3x4", "1x1x10"]) == 101
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day02.part_2(["../data/02.txt"]) == 1
    end
  end

  describe "parse_line/1" do
    test "with sample data" do
      assert Day02.parse_line("2x3x4") == %{length: 2, width: 3, height: 4}
      assert Day02.parse_line("1x1x10") == %{length: 1, width: 1, height: 10}
    end
  end

  describe "smallest_side/1" do
    test "with sample data" do
      assert Day02.smallest_side(%{length: 2, width: 3, height: 4}) == 6
      assert Day02.smallest_side(%{length: 1, width: 1, height: 10}) == 1
    end
  end

  describe "surface_area/1" do
    test "with sample data" do
      assert Day02.surface_area(%{length: 2, width: 3, height: 4}) == 52
      assert Day02.surface_area(%{length: 1, width: 1, height: 10}) == 42
    end
  end
end
