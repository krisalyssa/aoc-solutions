defmodule AoC.Day03.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert AoC.Day03.part_1([
               "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
             ]) == 161
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert AoC.Day03.part_2(["../data/03.txt"]) == 1
    end
  end
end
