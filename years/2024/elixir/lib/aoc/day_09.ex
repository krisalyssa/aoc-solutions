defmodule AoC.Day09 do
  @moduledoc false

  def run do
    IO.puts("day 09 part 1: #{AoC.Day09.part_1("../data/09.txt")}")
    IO.puts("day 09 part 2: #{AoC.Day09.part_2("../data/09.txt")}")
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
