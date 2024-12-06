defmodule AoC.Day05 do
  @moduledoc false

  @spec run() :: :ok
  def run do
    IO.puts("day 05 part 1: #{AoC.Day05.run_part_1("../data/05.txt")}")
    IO.puts("day 05 part 2: #{AoC.Day05.run_part_2("../data/05.txt")}")
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
    {rules, updates} = parse_data(data)

    updates
    |> Enum.filter(&valid?(&1, rules))
    |> Enum.map(&middle_page_number/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end

  def correct_order?({page1, page2}, rules) do
    if Enum.any?(rules, fn [a, b] -> page1 == b && page2 == a end) do
      false
    else
      true
    end
  end

  def middle_page_number(list), do: list |> AoC.bisect() |> elem(1) |> List.first()

  def parse_data(data) do
    {rules, updates} =
      data
      |> Enum.map(&String.trim/1)
      |> Enum.split_while(fn line -> String.length(line) > 0 end)

    {Enum.map(rules, &String.split(&1, "|")),
     updates
     |> Enum.filter(fn line -> String.length(line) > 0 end)
     |> Enum.map(&String.split(&1, ","))}
  end

  def valid?([], _) do
    true
  end

  def valid?([page1 | rest], rules) do
    if Enum.all?(rest, &correct_order?({page1, &1}, rules)) do
      valid?(rest, rules)
    else
      false
    end
  end
end
