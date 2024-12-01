defmodule AoC.Day12 do
  @moduledoc false

  def run do
    IO.puts("day 12 part 1: #{AoC.Day12.part_1("../data/12.txt")}")
    IO.puts("day 12 part 2: #{AoC.Day12.part_2("../data/12.txt")}")
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
