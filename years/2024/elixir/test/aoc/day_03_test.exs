defmodule AoC.Day03.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day03

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day03.part_1([
               "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
             ]) == 161
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day03.part_2([
               "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
             ]) == 48
    end
  end

  describe "extract_instructions/2" do
    test "with sample data" do
      assert Day03.extract_instructions(
               "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
               ~r/mul\(\d{1,3},\d{1,3}\)/
             ) == ["mul(2,4)", "mul(5,5)", "mul(11,8)", "mul(8,5)"]

      assert Day03.extract_instructions(
               "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
               ~r/do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\)/
             ) == ["mul(2,4)", "don't()", "mul(5,5)", "mul(11,8)", "do()", "mul(8,5)"]
    end
  end

  describe "run_instruction/2" do
    test "do()" do
      assert Day03.run_instruction("do()", %{enabled: false, acc: 0}) == %{enabled: true, acc: 0}
      assert Day03.run_instruction("do()", %{enabled: true, acc: 0}) == %{enabled: true, acc: 0}
    end

    test "don't()" do
      assert Day03.run_instruction("don't()", %{enabled: false, acc: 0}) == %{
               enabled: false,
               acc: 0
             }

      assert Day03.run_instruction("don't()", %{enabled: true, acc: 0}) == %{
               enabled: false,
               acc: 0
             }
    end

    test "mul()" do
      assert Day03.run_instruction("mul(2,3)", %{enabled: false, acc: 0}) == %{
               enabled: false,
               acc: 0
             }

      assert Day03.run_instruction("mul(2,3)", %{enabled: true, acc: 0}) == %{
               enabled: true,
               acc: 6
             }
    end
  end
end
