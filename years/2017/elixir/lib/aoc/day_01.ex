defmodule AoC.Day01 do
  @moduledoc false

  @spec run() :: :ok
  def run do
    IO.puts("day 01 part 1: #{AoC.Day01.run_part_1("../data/01.txt")}")
    IO.puts("day 01 part 2: #{AoC.Day01.run_part_2("../data/01.txt")}")
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
    |> Enum.to_list()
    |> List.first()
    |> chunk()
    |> Enum.filter(fn [a, b] -> a == b end)
    |> Enum.map(fn [a, _] -> a end)
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.to_list()
    |> List.first()
    |> bisect()
    |> Tuple.to_list()
    |> Enum.map(&digits/1)
    |> List.zip()
    |> Enum.filter(fn {a, b} -> a == b end)
    |> Enum.map(fn {a, _} -> a * 2 end)
    |> Enum.sum()
  end

  def bisect(str), do: String.split_at(str, Integer.floor_div(String.length(str), 2))

  def chunk(str),
    do:
      str
      |> digits()
      |> Enum.chunk_every(2, 1, [String.to_integer(String.first(str))])

  def digits(str), do: str |> String.trim() |> String.graphemes() |> Enum.map(&String.to_integer/1)
end
