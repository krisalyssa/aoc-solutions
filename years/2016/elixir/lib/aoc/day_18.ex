defmodule AoC.Day18 do
  @moduledoc false

  def run do
    IO.puts("day 18 part 1: #{AoC.Day18.part_1("../data/18.txt")}")
    IO.puts("day 18 part 2: #{AoC.Day18.part_2("../data/18.txt")}")
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
