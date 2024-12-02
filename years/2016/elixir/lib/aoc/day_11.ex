defmodule AoC.Day11 do
  @moduledoc false

  def run do
    IO.puts("day 11 part 1: #{AoC.Day11.part_1("../data/11.txt")}")
    IO.puts("day 11 part 2: #{AoC.Day11.part_2("../data/11.txt")}")
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
