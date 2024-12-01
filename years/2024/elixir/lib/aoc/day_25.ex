defmodule AoC.Day25 do
  @moduledoc false

  def run do
    IO.puts("day 25 part 1: #{AoC.Day25.part_1("../data/25.txt")}")
    IO.puts("day 25 part 2: #{AoC.Day25.part_2("../data/25.txt")}")
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
