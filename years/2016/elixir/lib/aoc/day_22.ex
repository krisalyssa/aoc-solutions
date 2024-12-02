defmodule AoC.Day22 do
  @moduledoc false

  def run do
    IO.puts("day 22 part 1: #{AoC.Day22.part_1("../data/22.txt")}")
    IO.puts("day 22 part 2: #{AoC.Day22.part_2("../data/22.txt")}")
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
