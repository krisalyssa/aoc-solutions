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
    |> Enum.map(&String.trim/1)
    |> Enum.map(&extract_instructions(&1, ~r/mul\(\d{1,3},\d{1,3}\)/))
    |> List.flatten()
    |> Enum.reduce(%{enabled: true, acc: 0}, &run_instruction/2)
    |> Map.get(:acc)
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.map(&String.trim/1)
    |> Enum.map(&extract_instructions(&1, ~r/do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\)/))
    |> List.flatten()
    |> Enum.reduce(%{enabled: true, acc: 0}, &run_instruction/2)
    |> Map.get(:acc)
  end

  def extract_instructions(str, regex), do: regex |> Regex.scan(str) |> List.flatten()

  def run_instruction("do()", state) do
    %{state | enabled: true}
  end

  def run_instruction("don't()", state) do
    %{state | enabled: false}
  end

  def run_instruction("mul(" <> _, %{enabled: false} = state) do
    state
  end

  def run_instruction("mul(" <> _ = inst, state) do
    [_, a_str, b_str] = Regex.run(~r/mul\((\d{1,3}),(\d{1,3})\)/, inst)
    {a, _} = Integer.parse(a_str)
    {b, _} = Integer.parse(b_str)
    Map.update!(state, :acc, &(&1 + a * b))
  end
end
