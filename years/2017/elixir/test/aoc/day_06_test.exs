defmodule AoC.Day06.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert AoC.Day06.part_1(["../data/06.txt"]) == 1
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert AoC.Day06.part_2(["../data/06.txt"]) == 1
    end
  end
end
