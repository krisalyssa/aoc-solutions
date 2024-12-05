defmodule AoC.Day01.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day01

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 2" do
    test "with sample data" do
      assert Day01.part_2(["../data/01.txt"]) == 1
    end
  end

  describe "instructions/1" do
    assert Day01.instructions("(())") == 0
    assert Day01.instructions("()()") == 0
    assert Day01.instructions("(((") == 3
    assert Day01.instructions("(()(()(") == 3
    assert Day01.instructions("))(((((") == 3
    assert Day01.instructions("())") == -1
    assert Day01.instructions("))(") == -1
    assert Day01.instructions(")))") == -3
    assert Day01.instructions(")())())") == -3
  end
end
