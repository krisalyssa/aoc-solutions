defmodule AoC.Day10 do
  @moduledoc false

  def run do
    IO.puts("day 10 part 1: #{AoC.Day10.part_1("../data/10.txt")}")
    IO.puts("day 10 part 2: #{AoC.Day10.part_2("../data/10.txt")}")
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
