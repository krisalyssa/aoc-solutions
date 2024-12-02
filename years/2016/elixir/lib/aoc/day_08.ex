defmodule AoC.Day08 do
  @moduledoc false

  def run do
    IO.puts("day 08 part 1: #{AoC.Day08.part_1("../data/08.txt")}")
    IO.puts("day 08 part 2: #{AoC.Day08.part_2("../data/08.txt")}")
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
