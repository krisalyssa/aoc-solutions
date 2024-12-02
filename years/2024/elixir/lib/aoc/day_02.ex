defmodule AoC.Day02 do
  @moduledoc false

  def run do
    IO.puts("day 02 part 1: #{AoC.Day02.part_1("../data/02.txt")}")
    IO.puts("day 02 part 2: #{AoC.Day02.part_2("../data/02.txt")}")
  end

  def part_1(filename) do
    filename
    |> File.stream!()
    |> parse_lines()
    |> Enum.filter(&is_safe/1)
    |> Enum.count()
  end

  def part_2(filename) do
    filename
    |> File.stream!()
    |> Enum.count()
  end

  @spec diffs([integer()]) :: [integer()]
  def diffs(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end

  def is_safe(report) do
    diff_list = diffs(report)
    safe_trend?(diff_list) && safe_diffs?(diff_list)
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

  def safe_diffs?(diffs), do: Enum.all?(diffs, fn d -> abs(d) >= 1 && abs(d) <= 3 end)

  def safe_trend?(diffs),
    do: Enum.all?(diffs, fn d -> d > 0 end) || Enum.all?(diffs, fn d -> d < 0 end)

  defp parseable?(""), do: false
  defp parseable?("\n"), do: false
  defp parseable?(_), do: true
end
