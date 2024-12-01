defmodule AoC.Day04 do
  @moduledoc false

  def run do
    IO.puts("day 04 part 1: #{AoC.Day04.part_1("../data/04.txt")}")
    IO.puts("day 04 part 2: #{AoC.Day04.part_2("../data/04.txt")}")
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
