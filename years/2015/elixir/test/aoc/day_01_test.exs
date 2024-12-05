defmodule AoC.Day01.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day01

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "instructions_part_1/1" do
    assert Day01.instructions_part_1("(())") == 0
    assert Day01.instructions_part_1("()()") == 0
    assert Day01.instructions_part_1("(((") == 3
    assert Day01.instructions_part_1("(()(()(") == 3
    assert Day01.instructions_part_1("))(((((") == 3
    assert Day01.instructions_part_1("())") == -1
    assert Day01.instructions_part_1("))(") == -1
    assert Day01.instructions_part_1(")))") == -3
    assert Day01.instructions_part_1(")())())") == -3
  end

  describe "instructions_part_2/1" do
    assert Day01.instructions_part_2(")") == 1
    assert Day01.instructions_part_2("()())") == 5
  end
end
