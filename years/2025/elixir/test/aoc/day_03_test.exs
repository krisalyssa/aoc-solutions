defmodule AoC.Day03.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day03

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      assert Day03.part_1([
               "987654321111111",
               "811111111111119",
               "234234234234278",
               "818181911112111"
             ]) == 357
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day03.part_2(["../data/03.txt"]) == 1
    end
  end

  describe "max_pair_in_bank/1" do
    test "with sample data" do
      assert Day03.max_pair_in_bank("987654321111111") == "98"
      assert Day03.max_pair_in_bank("811111111111119") == "89"
      assert Day03.max_pair_in_bank("234234234234278") == "78"
      assert Day03.max_pair_in_bank("818181911112111") == "92"
    end
  end

  describe "max_pair_in_subbank/1" do
    test "with sample data" do
      assert Day03.max_pair_in_subbank("987654321111111") == "98"
      assert Day03.max_pair_in_subbank("811111111111119") == "89"
      assert Day03.max_pair_in_subbank("234234234234278") == "28"
      assert Day03.max_pair_in_subbank("818181911112111") == "89"
    end
  end

  describe "pairs_with_first/1" do
    test "with sample data" do
      assert Day03.pairs_with_first("987654321111111") == [
               "91",
               "91",
               "91",
               "91",
               "91",
               "91",
               "91",
               "92",
               "93",
               "94",
               "95",
               "96",
               "97",
               "98"
             ]
    end
  end

  describe "subbanks/1" do
    test "with sample data" do
      assert Day03.subbanks("987654321111111") == [
               "987654321111111",
               "87654321111111",
               "7654321111111",
               "654321111111",
               "54321111111",
               "4321111111",
               "321111111",
               "21111111",
               "1111111",
               "111111",
               "11111",
               "1111",
               "111",
               "11",
               "1"
             ]
    end
  end
end
