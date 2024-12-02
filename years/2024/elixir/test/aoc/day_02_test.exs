defmodule AoC.Day02.Test do
  @moduledoc false

  use ExUnit.Case, async: false
  alias AoC.Day02

  # comment this out to always log to the console
  @moduletag :capture_log
  @sample_data """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  describe "part 1" do
    test "with sample data" do
      with temp_dir <- System.tmp_dir!(),
           temp_file <- "#{temp_dir}/2024-02-sample.txt",
           :ok <- File.write!(temp_file, @sample_data) do
        assert Day02.part_1(temp_file) == 2
      end
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day02.part_2("../data/02.txt") == 1000
    end
  end

  describe "diffs/1" do
    test("with sample data") do
      assert Day02.diffs([1, 3, 6, 7, 9]) == [2, 3, 1, 2]
      assert Day02.diffs([8, 6, 4, 4, 1]) == [-2, -2, 0, -3]
      assert Day02.diffs([1, 3, 2, 4, 5]) == [2, -1, 2, 1]
      assert Day02.diffs([9, 7, 6, 2, 1]) == [-2, -1, -4, -1]
      assert Day02.diffs([1, 2, 7, 8, 9]) == [1, 5, 1, 1]
      assert Day02.diffs([7, 6, 4, 2, 1]) == [-1, -2, -2, -1]
    end
  end

  describe "is_safe/1" do
    test "with sample data" do
      assert Day02.is_safe([1, 3, 6, 7, 9]) == true
      assert Day02.is_safe([8, 6, 4, 4, 1]) == false
      assert Day02.is_safe([1, 3, 2, 4, 5]) == false
      assert Day02.is_safe([9, 7, 6, 2, 1]) == false
      assert Day02.is_safe([1, 2, 7, 8, 9]) == false
      assert Day02.is_safe([7, 6, 4, 2, 1]) == true
    end
  end

  describe "parse_lines/1" do
    test "with sample data" do
      assert Day02.parse_lines(String.split(@sample_data, ~r/\n/)) == [
               [1, 3, 6, 7, 9],
               [8, 6, 4, 4, 1],
               [1, 3, 2, 4, 5],
               [9, 7, 6, 2, 1],
               [1, 2, 7, 8, 9],
               [7, 6, 4, 2, 1]
             ]
    end
  end

  describe "safe_diffs?/1" do
    test "with sample data" do
      assert Day02.safe_diffs?([2, 3, 1, 2]) == true
      assert Day02.safe_diffs?([-2, -2, 0, -3]) == false
      assert Day02.safe_diffs?([2, -1, 2, 1]) == true
      assert Day02.safe_diffs?([-2, -1, -4, -1]) == false
      assert Day02.safe_diffs?([1, 5, 1, 1]) == false
      assert Day02.safe_diffs?([-1, -2, -2, -1]) == true
    end
  end

  describe "safe_trend?/1" do
    test "with sample data" do
      assert Day02.safe_trend?([2, 3, 1, 2]) == true
      assert Day02.safe_trend?([-2, -2, 0, -3]) == false
      assert Day02.safe_trend?([2, -1, 2, 1]) == false
      assert Day02.safe_trend?([-2, -1, -4, -1]) == true
      assert Day02.safe_trend?([1, 5, 1, 1]) == true
      assert Day02.safe_trend?([-1, -2, -2, -1]) == true
    end
  end
end
