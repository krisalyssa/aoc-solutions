defmodule AoC.Day02.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day02

  # comment this out to always log to the console
  @moduletag :capture_log

  describe "part 1" do
    test "with sample data" do
      input =
        "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

      assert Day02.part_1([input]) == 1_227_775_554
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day02.part_2(["../data/02.txt"]) == 1
    end
  end

  describe "expand_range/1" do
    test "with sample data" do
      assert Enum.to_list(Day02.expand_range("11-22")) == [
               "11",
               "12",
               "13",
               "14",
               "15",
               "16",
               "17",
               "18",
               "19",
               "20",
               "21",
               "22"
             ]
    end
  end

  describe "find_invalid_ids/1" do
    test "with sample data" do
      assert Enum.to_list(Day02.find_invalid_ids("11-22")) == ["11", "22"]
      assert Enum.to_list(Day02.find_invalid_ids("95-115")) == ["99"]
      assert Enum.to_list(Day02.find_invalid_ids("998-1012")) == ["1010"]
      assert Enum.to_list(Day02.find_invalid_ids("1188511880-1188511890")) == ["1188511885"]
      assert Enum.to_list(Day02.find_invalid_ids("222220-222224")) == ["222222"]
      assert Enum.to_list(Day02.find_invalid_ids("1698522-1698528")) == []
      assert Enum.to_list(Day02.find_invalid_ids("446443-446449")) == ["446446"]
      assert Enum.to_list(Day02.find_invalid_ids("38593856-38593862")) == ["38593859"]
    end
  end

  describe "invalid?/1" do
    test "with sample data" do
      assert Day02.invalid?("55") == true
      assert Day02.invalid?("6464") == true
      assert Day02.invalid?("123123") == true
      assert Day02.invalid?("1698522") == false
      assert Day02.invalid?("1698528") == false
    end
  end
end
