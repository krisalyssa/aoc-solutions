defmodule AoC.Day05 do
  @moduledoc false

  @spec run() :: :ok
  def run, do: IO.puts(AoC.print(5, AoC.Day05.run_part_1("../data/05.txt"), AoC.Day05.run_part_2("../data/05.txt")))

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
    |> Enum.filter(&all_valid?(&1, rules))
    |> Enum.map(&middle_page_number/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    {rules, updates} = parse_data(data)

    updates
    |> Enum.reject(&all_valid?(&1, rules))
    |> Enum.map(fn update -> fix(update, rules, false) end)
    |> Enum.map(&middle_page_number/1)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def all_valid?(update, rules) do
    indexes = update |> Enum.with_index() |> Map.new()

    Enum.all?(rules, fn rule -> valid?(indexes, rule) end)
  end

  def correct_order?({page1, page2}, rules) do
    if Enum.any?(rules, fn [a, b] -> page1 == b && page2 == a end) do
      false
    else
      true
    end
  end

  def fix(update, _, true) do
    update
  end

  def fix(update, rules, false) do
    indexes = update |> Enum.with_index() |> Map.new()
    [left, right] = invalid_indexes(indexes, rules)
    fixed = swap(update, Map.get(indexes, left), Map.get(indexes, right))
    fix(fixed, rules, all_valid?(fixed, rules))
  end

  def invalid_indexes(update_with_indexes, rules) do
    Enum.find(rules, fn [left, right] ->
      left_index = Map.get(update_with_indexes, left)
      right_index = Map.get(update_with_indexes, right)

      if is_nil(left_index) || is_nil(right_index) do
        false
      else
        left_index > right_index
      end
    end)
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

  # from https://elixirforum.com/t/how-to-swap-elements-in-a-list/34471/8
  def swap(a, i1, i2) do
    a = :array.from_list(a)

    v1 = :array.get(i1, a)
    v2 = :array.get(i2, a)

    a = :array.set(i1, v2, a)
    a = :array.set(i2, v1, a)

    :array.to_list(a)
  end

  def valid?(indexes, [left, right]) do
    left_index = Map.get(indexes, left)
    right_index = Map.get(indexes, right)

    if is_nil(left_index) || is_nil(right_index) do
      true
    else
      left_index < right_index
    end
  end
end
