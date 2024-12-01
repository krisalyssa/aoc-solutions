defmodule AoC.Day20 do
  @moduledoc false

  def run do
    IO.puts("day 20 part 1: #{AoC.Day20.part_1("../data/20.txt")}")
    IO.puts("day 20 part 2: #{AoC.Day20.part_2("../data/20.txt")}")
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
