defmodule AoC.Day19 do
  @moduledoc false

  def run do
    IO.puts("day 19 part 1: #{AoC.Day19.part_1("../data/19.txt")}")
    IO.puts("day 19 part 2: #{AoC.Day19.part_2("../data/19.txt")}")
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
