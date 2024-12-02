defmodule AoC.Day13 do
  @moduledoc false

  def run do
    IO.puts("day 13 part 1: #{AoC.Day13.part_1("../data/13.txt")}")
    IO.puts("day 13 part 2: #{AoC.Day13.part_2("../data/13.txt")}")
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
