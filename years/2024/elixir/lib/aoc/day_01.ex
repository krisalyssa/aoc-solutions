defmodule AoC.Day01 do
  @moduledoc false

  def run do
    IO.puts("day 01 part 1: #{AoC.Day01.part_1("../data/01.txt")}")
    IO.puts("day 01 part 2: #{AoC.Day01.part_2("../data/01.txt")}")
  end

  def part_1(filename) do
    filename
    |> File.stream!()
    |> parse_lines()
    |> distances()
    |> total_distance()
  end

  def part_2(filename) do
    filename
    |> File.stream!()
    |> Enum.count()
  end

  @spec distances({[integer()], [integer()]}) :: [integer()]
  def distances({list1, list2}) do
    with sorted1 <- Enum.sort(list1),
         sorted2 <- Enum.sort(list2) do
      Enum.zip_with(sorted1, sorted2, fn item1, item2 -> abs(item1 - item2) end)
    end
  end

  @spec parse_lines(Enumerable.t()) :: {[integer()], [integer()]}
  def parse_lines(data) do
    Enum.reduce(data, {[], []}, fn line, {list1, list2} ->
      with str1 <- Regex.scan(~r/(\d+)\s+\d+/, line) |> List.first() |> Enum.at(1),
           {int1, _} <- Integer.parse(str1),
           str2 <- Regex.scan(~r/\d+\s+(\d+)/, line) |> List.first() |> Enum.at(1),
           {int2, _} <- Integer.parse(str2) do
        {[int1 | list1], [int2 | list2]}
      end
    end)
  end

  def total_distance(list), do: Enum.sum(list)
end
