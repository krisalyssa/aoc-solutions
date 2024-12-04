defmodule AoC.Day03 do
  @moduledoc false

  @spec run() :: :ok
  def run do
    IO.puts("day 03 part 1: #{AoC.Day03.run_part_1("../data/03.txt")}")
    IO.puts("day 03 part 2: #{AoC.Day03.run_part_2("../data/03.txt")}")
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
    |> Enum.map(&String.trim/1)
    |> Enum.map(&extract_instructions/1)
    |> List.flatten()
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end

  defp extract_instructions(str) do
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, str)
    |> Enum.map(fn [_, a_str, b_str] ->
      {a, _} = Integer.parse(a_str)
      {b, _} = Integer.parse(b_str)
      {a, b}
    end)
    |> Enum.reduce([], fn {a, b}, acc -> [a * b | acc] end)
  end
end
