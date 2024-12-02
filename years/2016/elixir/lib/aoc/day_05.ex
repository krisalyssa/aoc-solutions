defmodule AoC.Day05 do
  @moduledoc false

  def run do
    IO.puts("day 05 part 1: #{AoC.Day05.part_1("../data/05.txt")}")
    IO.puts("day 05 part 2: #{AoC.Day05.part_2("../data/05.txt")}")
  end

  def part_1(filename) do
    filename
    |> File.stream!()
    |> Enum.count()
  end

  def part_2(filename) do
    filename
    |> File.stream!()
    |> Enum.count()
  end
end
