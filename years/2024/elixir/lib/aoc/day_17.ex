defmodule AoC.Day17 do
  @moduledoc false

  def run do
    IO.puts("day 17 part 1: #{AoC.Day17.part_1("../data/17.txt")}")
    IO.puts("day 17 part 2: #{AoC.Day17.part_2("../data/17.txt")}")
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
