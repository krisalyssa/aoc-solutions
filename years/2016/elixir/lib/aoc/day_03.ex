defmodule AoC.Day03 do
  @moduledoc false

  def run do
    IO.puts("day 03 part 1: #{AoC.Day03.part_1("../data/03.txt")}")
    IO.puts("day 03 part 2: #{AoC.Day03.part_2("../data/03.txt")}")
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
