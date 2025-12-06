defmodule AoC.Day02 do
  @moduledoc false

  @spec run() :: :ok
  def run,
    do:
      IO.puts(
        AoC.print(
          2,
          AoC.Day02.run_part_1("../data/02.txt"),
          AoC.Day02.run_part_2("../data/02.txt")
        )
      )

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
    |> Enum.map(&String.split(&1, ~r/\s*,\s*/))
    |> List.flatten()
    |> Enum.map(&find_invalid_ids/1)
    |> Enum.map(&Enum.to_list/1)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(0, fn e, acc -> acc + e end)
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.map(&String.split(&1, ~r/\s*,\s*/))
    |> List.flatten()
    |> Enum.map(&find_invalid_ids_long/1)
    |> Enum.map(&Enum.to_list/1)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(0, fn e, acc -> acc + e end)
  end

  @spec expand_range(range :: String.t()) :: Stream.t()
  def expand_range(range) do
    [range_start, range_end] =
      range
      |> String.trim()
      |> String.split(~r/\s*-\s*/)
      |> Enum.map(&String.to_integer/1)

    range_start
    |> Stream.from_index()
    |> Stream.take_while(fn e -> e <= range_end end)
    |> Stream.map(&Integer.to_string/1)
    |> Enum.to_list()
  end

  @spec find_invalid_ids(range :: String.t()) :: Stream.t()
  def find_invalid_ids(range) do
    range
    |> expand_range()
    |> Stream.filter(&invalid?/1)
  end

  @spec find_invalid_ids_long(range :: String.t()) :: Stream.t()
  def find_invalid_ids_long(range) do
    range
    |> expand_range()
    |> Stream.filter(&invalid_long?/1)
  end

  @spec invalid?(id :: String.t()) :: bool()
  def invalid?(id), do: Regex.match?(~r/^(\d+)\1$/, id)

  @spec invalid_long?(id :: String.t()) :: bool()
  def invalid_long?(id), do: Regex.match?(~r/^(\d+)(\1)+$/, id)
end
