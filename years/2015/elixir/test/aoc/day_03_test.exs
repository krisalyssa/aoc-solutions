defmodule AoC.Day03.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day03

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day03.part_1([">"]) == 2
      assert Day03.part_1(["^>v<"]) == 4
      assert Day03.part_1(["^v^v^v^v^v"]) == 2
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day03.part_2(["^v"]) == 3
      assert Day03.part_2(["^>v<"]) == 3
      assert Day03.part_2(["^v^v^v^v^v"]) == 11
    end
  end

  describe "move_all/1" do
    test "with sample data" do
      assert Day03.move_all(">", {%{{0, 0} => 1}, [{0, 0}]}) ==
               {%{{0, 0} => 1, {1, 0} => 1}, [{1, 0}]}

      assert Day03.move_all("^>v<", {%{{0, 0} => 1}, [{0, 0}]}) ==
               {%{{0, 0} => 2, {1, 0} => 1, {1, 1} => 1, {0, 1} => 1}, [{0, 0}]}

      assert Day03.move_all("^v^v^v^v^v", {%{{0, 0} => 1}, [{0, 0}]}) ==
               {%{{0, 0} => 6, {0, 1} => 5}, [{0, 0}]}
    end
  end
end
