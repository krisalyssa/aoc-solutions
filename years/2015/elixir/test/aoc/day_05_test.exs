defmodule AoC.Day05.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day05

  # comment this out to always log to the console
  @moduletag :capture_log

  # describe "part 1" do
  #   test "with sample data" do
  #   end
  # end

  describe "part 2" do
    test "with sample data" do
      assert Day05.part_2(["../data/05.txt"]) == 1
    end
  end

  describe "at_least_three_vowels?/1" do
    test "with sample data" do
      assert Day05.at_least_three_vowels?("aei")
      assert Day05.at_least_three_vowels?("xazegov")
      assert Day05.at_least_three_vowels?("aeiouaeiouaeiou")

      assert Day05.at_least_three_vowels?("ugknbfddgicrmopn")
      assert Day05.at_least_three_vowels?("aaa")
      assert Day05.at_least_three_vowels?("jchzalrnumimnmhp")
      assert Day05.at_least_three_vowels?("haegwjzuvuyypxyu")
      refute Day05.at_least_three_vowels?("dvszwmarrgswjxmb")
    end
  end

  describe "doubled_letters?/1" do
    test "with sample data" do
      assert Day05.doubled_letters?("xx")
      assert Day05.doubled_letters?("abcdde")
      assert Day05.doubled_letters?("aabbccdd")

      assert Day05.doubled_letters?("ugknbfddgicrmopn")
      assert Day05.doubled_letters?("aaa")
      refute Day05.doubled_letters?("jchzalrnumimnmhp")
      assert Day05.doubled_letters?("haegwjzuvuyypxyu")
      assert Day05.doubled_letters?("dvszwmarrgswjxmb")
    end
  end

  describe "nice?/1" do
    test "with sample data" do
      assert Day05.nice?("ugknbfddgicrmopn")
      assert Day05.nice?("aaa")
      refute Day05.nice?("jchzalrnumimnmhp")
      refute Day05.nice?("haegwjzuvuyypxyu")
      refute Day05.nice?("dvszwmarrgswjxmb")
    end
  end

  describe "no_forbidden_strings?/1" do
    test "with sample data" do
      assert Day05.no_forbidden_strings?("ugknbfddgicrmopn")
      assert Day05.no_forbidden_strings?("aaa")
      assert Day05.no_forbidden_strings?("jchzalrnumimnmhp")
      refute Day05.no_forbidden_strings?("haegwjzuvuyypxyu")
      assert Day05.no_forbidden_strings?("dvszwmarrgswjxmb")
    end
  end
end
