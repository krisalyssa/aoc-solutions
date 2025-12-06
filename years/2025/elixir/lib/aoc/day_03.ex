defmodule AoC.Day03 do
  @moduledoc false

  @spec run() :: :ok
  def run,
    do:
      IO.puts(
        AoC.print(
          3,
          AoC.Day03.run_part_1("../data/03.txt"),
          AoC.Day03.run_part_2("../data/03.txt")
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
  def part_1(data),
    do: Enum.reduce(data, 0, fn p, acc -> acc + String.to_integer(max_pair_in_bank(p)) end)

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end

  @spec max_pair_in_bank(String.t()) :: String.t()
  def max_pair_in_bank(bank) do
    bank
    |> String.trim()
    |> subbanks()
    |> Enum.reject(fn b -> String.length(b) < 2 end)
    |> Enum.map(&max_pair_in_subbank/1)
    |> Enum.max_by(&String.to_integer/1)
  end

  @spec max_pair_in_subbank(String.t()) :: String.t()
  def max_pair_in_subbank(subbank) do
    subbank
    |> pairs_with_first()
    |> Enum.max_by(&String.to_integer/1)
  end

  @spec pairs_with_first(String.t()) :: [integer]
  def pairs_with_first(bank) do
    [left | all_right] = String.graphemes(bank)
    Enum.reduce(all_right, [], fn r, acc -> [left <> r | acc] end)
  end

  @spec subbanks(String.t()) :: [String.t()]
  def subbanks(""), do: []
  def subbanks(bank), do: [bank | subbanks(String.slice(bank, 1..-1//1))]
end
