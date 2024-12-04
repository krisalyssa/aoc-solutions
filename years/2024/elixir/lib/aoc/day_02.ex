defmodule AoC.Day02 do
  @moduledoc false

  @spec run() :: :ok
  def run do
    IO.puts("day 02 part 1: #{AoC.Day02.run_part_1("../data/02.txt")}")
    IO.puts("day 02 part 2: #{AoC.Day02.run_part_2("../data/02.txt")}")
  end

  @spec run_part_1(String.t()) :: integer()
  def run_part_1(filename) do
    filename
    |> File.stream!()
    |> part_1()
  end

  @spec run_part_2(String.t()) :: integer()
  def run_part_2(filename) do
    filename
    |> File.stream!()
    |> part_2()
  end

  @spec part_1(Enumerable.t()) :: integer()
  def part_1(data) do
    data
    |> parse_lines()
    |> Enum.count(&safe?/1)
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> parse_lines()
    |> Enum.count(&safe_after_dampening?/1)
  end

  @spec dampen([integer()]) :: [[integer()]]
  def dampen(report),
    do:
      Enum.reduce(0..(Enum.count(report) - 1), [], fn n, acc ->
        [List.delete_at(report, n) | acc]
      end)

  @spec diffs([integer()]) :: [integer()]
  def diffs(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end

  @spec parse_lines(Enumerable.t()) :: [[integer()]]
  def parse_lines(data) do
    Enum.reduce(data, [], fn line, list ->
      if parseable?(line) do
        line_list =
          line
          |> String.trim()
          |> String.split(~r/\s+/)
          |> Enum.map(&Integer.parse/1)
          |> Enum.map(&elem(&1, 0))

        [line_list | list]
      else
        list
      end
    end)
  end

  @spec safe?([integer()]) :: boolean()
  def safe?(report) do
    diff_list = diffs(report)
    safe_trend?(diff_list) && safe_diffs?(diff_list)
  end

  @spec safe_after_dampening?([integer()]) :: boolean()
  def safe_after_dampening?(report) do
    report
    |> dampen()
    |> Enum.any?(&safe?/1)
  end

  @spec safe_diffs?([integer()]) :: boolean()
  def safe_diffs?(diffs), do: Enum.all?(diffs, fn d -> abs(d) >= 1 && abs(d) <= 3 end)

  @spec safe_trend?([integer()]) :: boolean()
  def safe_trend?(diffs),
    do: Enum.all?(diffs, fn d -> d > 0 end) || Enum.all?(diffs, fn d -> d < 0 end)

  defp parseable?(""), do: false
  defp parseable?("\n"), do: false
  defp parseable?(_), do: true
end
