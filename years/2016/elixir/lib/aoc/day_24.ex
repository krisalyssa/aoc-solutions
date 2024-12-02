defmodule AoC.Day24 do
  @moduledoc false

  def run do
    IO.puts("day 24 part 1: #{AoC.Day24.part_1("../data/24.txt")}")
    IO.puts("day 24 part 2: #{AoC.Day24.part_2("../data/24.txt")}")
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
