defmodule AoC.Day23 do
  @moduledoc false

  def run do
    IO.puts("day 23 part 1: #{AoC.Day23.part_1("../data/23.txt")}")
    IO.puts("day 23 part 2: #{AoC.Day23.part_2("../data/23.txt")}")
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
