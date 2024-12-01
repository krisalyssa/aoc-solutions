defmodule AoC.Day14 do
  @moduledoc false

  def run do
    IO.puts("day 14 part 1: #{AoC.Day14.part_1("../data/14.txt")}")
    IO.puts("day 14 part 2: #{AoC.Day14.part_2("../data/14.txt")}")
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
