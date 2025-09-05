defmodule AoC.Day05 do
  @moduledoc false

  @spec run() :: :ok
  def run,
    do:
      IO.puts(
        AoC.print(
          5,
          AoC.Day05.run_part_1("../data/05.txt"),
          AoC.Day05.run_part_2("../data/05.txt")
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
    |> Enum.filter(&nice?/1)
    |> Enum.count()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end

  def at_least_three_vowels?(str) do
    ~r/[aeiou]/
    |> Regex.scan(str)
    |> Enum.count()
    |> then(fn v -> v >= 3 end)
  end

  def doubled_letters?(str) do
    ~r/(.)\1/
    |> Regex.scan(str)
    |> Enum.count()
    |> then(fn v -> v > 0 end)
  end

  def nice?(str) do
    with true <- at_least_three_vowels?(str),
         true <- doubled_letters?(str),
         true <- no_forbidden_strings?(str) do
      true
    else
      _ -> false
    end
  end

  def no_forbidden_strings?(str) do
    ~r/ab|cd|pq|xy/
    |> Regex.scan(str)
    |> Enum.count()
    |> then(fn v -> v == 0 end)
  end
end
