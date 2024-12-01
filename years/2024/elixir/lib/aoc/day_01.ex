defmodule AoC.Day01 do
  @moduledoc false

  def run do
    IO.puts("day 01 part 1: #{AoC.Day01.part_1("../data/01.txt")}")
    IO.puts("day 01 part 2: #{AoC.Day01.part_2("../data/01.txt")}")
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
