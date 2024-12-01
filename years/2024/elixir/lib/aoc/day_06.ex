defmodule AoC.Day06 do
  @moduledoc false

  def run do
    IO.puts("day 06 part 1: #{AoC.Day06.part_1("../data/06.txt")}")
    IO.puts("day 06 part 2: #{AoC.Day06.part_2("../data/06.txt")}")
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
