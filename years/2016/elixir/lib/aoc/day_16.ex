defmodule AoC.Day16 do
  @moduledoc false

  def run do
    IO.puts("day 16 part 1: #{AoC.Day16.part_1("../data/16.txt")}")
    IO.puts("day 16 part 2: #{AoC.Day16.part_2("../data/16.txt")}")
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
