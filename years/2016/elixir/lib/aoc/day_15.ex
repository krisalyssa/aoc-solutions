defmodule AoC.Day15 do
  @moduledoc false

  def run do
    IO.puts("day 15 part 1: #{AoC.Day15.part_1("../data/15.txt")}")
    IO.puts("day 15 part 2: #{AoC.Day15.part_2("../data/15.txt")}")
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
