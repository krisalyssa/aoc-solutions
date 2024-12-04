defmodule AoC.Day04.Test do
  @moduledoc false

  use ExUnit.Case, async: false

  alias AoC.Day04

  # comment this out to always log to the console
  @moduletag :capture_log

  @sample_data [
    "MMMSXXMASM",
    "MSAMXMSMSA",
    "AMXSXMAAMM",
    "MSAMASMSMX",
    "XMASAMXAMM",
    "XXAMMXXAMA",
    "SMSMSASXSS",
    "SAXAMASAAA",
    "MAMMMXMMMM",
    "MXMXAXMASX"
  ]

  describe "part 1" do
    test "with sample data" do
      assert Day04.part_1(@sample_data) == 18
    end
  end

  describe "part 2" do
    test "with sample data" do
      assert Day04.part_2(@sample_data) == 9
    end
  end

  describe "get_bltr/2" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.get_bltr(grid, {9, 0}) == "MAXM"
      assert Day04.get_bltr(grid, {8, 4}) == "MASA"
    end
  end

  describe "get_brtl/2" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.get_brtl(grid, {9, 9}) == "XMAS"
      assert Day04.get_brtl(grid, {7, 6}) == "SAMS"
    end
  end

  describe "get_tlbr/2" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.get_tlbr(grid, {0, 0}) == "MSXM"
      assert Day04.get_tlbr(grid, {3, 1}) == "SAMS"
    end
  end

  describe "get_trbl/2" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.get_trbl(grid, {0, 9}) == "MSAM"
      assert Day04.get_trbl(grid, {5, 8}) == "MXSX"
    end
  end

  describe "load_grid/1" do
    test "with sample data" do
      assert Day04.load_grid(@sample_data) == [
               ~c"MMMSXXMASM",
               ~c"MSAMXMSMSA",
               ~c"AMXSXMAAMM",
               ~c"MSAMASMSMX",
               ~c"XMASAMXAMM",
               ~c"XXAMMXXAMA",
               ~c"SMSMSASXSS",
               ~c"SAXAMASAAA",
               ~c"MAMMMXMMMM",
               ~c"MXMXAXMASX"
             ]
    end
  end

  describe "load_row/1" do
    test "with sample data" do
      assert Day04.load_row("MMMSXXMASM") == [~c"MMMSXXMASM"]
    end
  end

  describe "scan_bltr/1" do
    test "with sample data" do
      assert Day04.scan_bltr(Day04.load_grid(@sample_data)) == 4
    end
  end

  describe "scan_brtl/1" do
    test "with sample data" do
      assert Day04.scan_brtl(Day04.load_grid(@sample_data)) == 4
    end
  end

  describe "scan_bt/1" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.scan_bt(grid) == 2
    end
  end

  describe "scan_line/1" do
    test "with sample data" do
      assert Day04.scan_line("MMMSXXMASM") == 1
      assert Day04.scan_line("MSAMXMSMSA") == 0
    end
  end

  describe "scan_lr/1" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.scan_lr(grid) == 3
    end
  end

  describe "scan_rl/1" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.scan_rl(grid) == 2
    end
  end

  describe "scan_tb/1" do
    test "with sample data" do
      grid = Day04.load_grid(@sample_data)
      assert Day04.scan_tb(grid) == 1
    end
  end

  describe "scan_tlbr/1" do
    test "with sample data" do
      assert Day04.scan_tlbr(Day04.load_grid(@sample_data)) == 1
    end
  end

  describe "scan_trbl/1" do
    test "with sample data" do
      assert Day04.scan_trbl(Day04.load_grid(@sample_data)) == 1
    end
  end

  describe "scan_xmas/1" do
    test "with sample data" do
      assert Day04.scan_xmas(Day04.load_grid(@sample_data)) == 9
    end
  end
end
