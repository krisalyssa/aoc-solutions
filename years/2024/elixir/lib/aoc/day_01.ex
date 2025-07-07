defmodule AoC.Day01 do
  @moduledoc false

  @spec run() :: :ok
  def run, do: IO.puts(AoC.print(1, AoC.Day01.run_part_1("../data/01.txt"), AoC.Day01.run_part_2("../data/01.txt")))

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

  @spec part_1(Enumerable.t()) :: number()
  def part_1(data) do
    data
    |> parse_lines()
    |> distances()
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: number()
  def part_2(data) do
    data
    |> parse_lines()
    |> similarity_scores()
    |> Enum.sum()
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

  @spec similarity_scores({[integer()], [integer()]}) :: [integer()]
  def similarity_scores({list1, list2}) do
    frequencies = Enum.frequencies(list2)
    Enum.map(list1, fn n -> n * Map.get(frequencies, n, 0) end)
  end

  @spec total_distance([integer()]) :: integer()
  def total_distance(list), do: Enum.sum(list)
end
