defmodule AoC.Day02 do
  @moduledoc false

  def run do
    IO.puts("day 02 part 1: #{AoC.Day02.part_1("../data/02.txt")}")
    IO.puts("day 02 part 2: #{AoC.Day02.part_2("../data/02.txt")}")
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
