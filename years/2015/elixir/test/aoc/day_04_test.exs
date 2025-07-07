defmodule AoC.Day04.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day04

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day04.part_1(["../data/04.txt"]) == 1
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day04.part_2(["../data/04.txt"]) == 1
    end
  end

  describe "advent_coin/1" do
    test "with sample data" do
      assert Day04.advent_coin("abcdef") == 609043
      assert Day04.advent_coin("pqrstuv") == 1048970
    end
  end

  describe "advent_coin/2" do
    test "with sample data" do
      assert Day04.advent_coin("abcdef", 609043) == 609043
      assert Day04.advent_coin("pqrstuv", 1048970) == 1048970
    end
  end

  describe "md5/1" do
    test "with sample data" do
      assert Day04.md5("abcdef609043") == "000001dbbfa3a5c83a2d506429c7b00e"
      assert Day04.md5("pqrstuv1048970") == "000006136ef2ff3b291c85725f17325c"
    end
  end
end
