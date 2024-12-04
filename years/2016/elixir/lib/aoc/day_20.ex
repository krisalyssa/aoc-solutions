defmodule AoC.Day20 do
  @moduledoc false

  @spec run() :: :ok
  def run do
    IO.puts("day 20 part 1: #{AoC.Day20.run_part_1("../data/20.txt")}")
    IO.puts("day 20 part 2: #{AoC.Day20.run_part_2("../data/20.txt")}")
  end

  @spec run_part_1(String.t()) :: number()
  def run_part_1(filename) do
    filename
    |> File.stream!()
    |> part_1()
  end

  @spec run_part_2(String.t()) :: number()
  def run_part_2(filename) do
    filename
    |> File.stream!()
    |> part_2()
  end

  @spec part_1(Enumerable.t()) :: integer()
  def part_1(data) do
    data
    |> Enum.count()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end
end
