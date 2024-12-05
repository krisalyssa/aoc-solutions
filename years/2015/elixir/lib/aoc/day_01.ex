defmodule AoC.Day01 do
  @moduledoc false

  @spec run() :: :ok
  def run do
    IO.puts("day 01 part 1: #{AoC.Day01.run_part_1("../data/01.txt")}")
    IO.puts("day 01 part 2: #{AoC.Day01.run_part_2("../data/01.txt")}")
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
    data
    |> Enum.to_list()
    |> List.first()
    |> instructions_part_1()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.to_list()
    |> List.first()
    |> instructions_part_2()
  end

  @spec instructions_part_1(String.t()) :: integer()
  def instructions_part_1(str) do
    str
    |> String.graphemes()
    |> Enum.with_index(1)
    |> Enum.reduce_while(0, fn
      {"(", _index}, acc ->
        {:cont, acc + 1}

      {")", _index}, acc ->
        {:cont, acc - 1}
    end)
  end

  @spec instructions_part_2(String.t()) :: integer()
  def instructions_part_2(str) do
    str
    |> String.graphemes()
    |> Enum.with_index(1)
    |> Enum.reduce_while(0, fn
      {"(", _index}, acc ->
        {:cont, acc + 1}

      {")", index}, acc ->
        if acc > 0 do
          {:cont, acc - 1}
        else
          {:halt, index}
        end
    end)
  end
end
