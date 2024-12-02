defmodule AoC.Day07 do
  @moduledoc false

  def run do
    IO.puts("day 07 part 1: #{AoC.Day07.part_1("../data/07.txt")}")
    IO.puts("day 07 part 2: #{AoC.Day07.part_2("../data/07.txt")}")
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
