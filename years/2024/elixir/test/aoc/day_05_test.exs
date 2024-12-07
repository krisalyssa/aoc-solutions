defmodule AoC.Day05.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day05

  # comment this out to always log to the console
  @moduletag :capture_log

  @sample_data ~S"""
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
  """

  describe "part 1" do
    test "with sample data" do
      assert Day05.part_1(@sample_data |> String.split("\n") |> Enum.drop(1)) == 143
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day05.part_2(@sample_data |> String.split("\n") |> Enum.drop(1)) == 123
    end
  end

  describe "correct_order/2" do
    test "with sample data" do
      {rules, _} = @sample_data |> String.split("\n") |> Enum.drop(1) |> Day05.parse_data()

      # ["75", "47", "61", "53", "29"]
      assert Day05.correct_order?({"75", "47"}, rules) == true
      assert Day05.correct_order?({"75", "61"}, rules) == true
      assert Day05.correct_order?({"75", "53"}, rules) == true
      assert Day05.correct_order?({"75", "29"}, rules) == true

      # ["75", "97", "47", "61", "53"]
      assert Day05.correct_order?({"75", "97"}, rules) == false

      # ["61", "13", "29"]
      assert Day05.correct_order?({"61", "13"}, rules) == true
      assert Day05.correct_order?({"61", "29"}, rules) == true
      assert Day05.correct_order?({"13", "29"}, rules) == false
    end
  end

  describe "middle_page_number/1" do
    test "with sample data" do
      assert Day05.middle_page_number(["75", "47", "61", "53", "29"]) == "61"
      assert Day05.middle_page_number(["97", "61", "53", "29", "13"]) == "53"
      assert Day05.middle_page_number(["75", "29", "13"]) == "29"
      assert Day05.middle_page_number(["75", "97", "47", "61", "53"]) == "47"
      assert Day05.middle_page_number(["61", "13", "29"]) == "13"
      assert Day05.middle_page_number(["97", "13", "75", "29", "47"]) == "75"
    end
  end

  describe "parse_data/1" do
    test "with sample data" do
      # trim_leading/1 because there's a newline at the beginning
      assert Day05.parse_data(@sample_data |> String.split("\n") |> Enum.drop(1)) == {
               [
                 ["97", "13"],
                 ["97", "61"],
                 ["97", "47"],
                 ["75", "29"],
                 ["61", "13"],
                 ["75", "53"],
                 ["29", "13"],
                 ["97", "29"],
                 ["53", "29"],
                 ["61", "53"],
                 ["97", "53"],
                 ["61", "29"],
                 ["47", "13"],
                 ["75", "47"],
                 ["97", "75"],
                 ["47", "61"],
                 ["75", "61"],
                 ["47", "29"],
                 ["75", "13"],
                 ["53", "13"]
               ],
               [
                 ["75", "47", "61", "53", "29"],
                 ["97", "61", "53", "29", "13"],
                 ["75", "29", "13"],
                 ["75", "97", "47", "61", "53"],
                 ["61", "13", "29"],
                 ["97", "13", "75", "29", "47"]
               ]
             }
    end
  end

  describe "all_valid?/2" do
    test "with sample data" do
      {rules, _} = @sample_data |> String.split("\n") |> Enum.drop(1) |> Day05.parse_data()

      assert Day05.all_valid?(["75", "47", "61", "53", "29"], rules) == true
      assert Day05.all_valid?(["97", "61", "53", "29", "13"], rules) == true
      assert Day05.all_valid?(["75", "29", "13"], rules) == true
      assert Day05.all_valid?(["75", "97", "47", "61", "53"], rules) == false
      assert Day05.all_valid?(["61", "13", "29"], rules) == false
      assert Day05.all_valid?(["97", "13", "75", "29", "47"], rules) == false
    end
  end
end
