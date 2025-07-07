defmodule AoC.Day04 do
  @moduledoc false

  @spec run() :: :ok
  def run,
    do:
      IO.puts(
        AoC.print(
          4,
          AoC.Day04.run_part_1("../data/04.txt"),
          AoC.Day04.run_part_2("../data/04.txt")
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
    |> Enum.take(1)
    |> List.first()
    |> String.trim()
    |> advent_coin()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end

  def advent_coin(prefix), do: advent_coin(prefix, 1)

  def advent_coin(prefix, index) do
    case md5("#{prefix}#{index}") do
      "00000" <> _ ->
        index

      _ ->
        advent_coin(prefix, index + 1)
      end
  end

  def md5(str), do: :crypto.hash(:md5, str) |> Base.encode16(case: :lower)
end
