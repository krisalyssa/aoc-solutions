defmodule AoC.Day03 do
  @moduledoc false

  @spec run() :: :ok
  def run, do: IO.puts(AoC.print(3, AoC.Day03.run_part_1("../data/03.txt"), AoC.Day03.run_part_2("../data/03.txt")))

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
    |> Enum.count()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end
end
