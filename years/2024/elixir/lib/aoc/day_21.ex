defmodule AoC.Day21 do
  @moduledoc false

  def run do
    IO.puts("day 21 part 1: #{AoC.Day21.part_1("../data/21.txt")}")
    IO.puts("day 21 part 2: #{AoC.Day21.part_2("../data/21.txt")}")
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
