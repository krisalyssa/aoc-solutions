defmodule AoC.Day01 do
  @moduledoc false

  @spec run() :: :ok
  def run,
    do:
      IO.puts(
        AoC.print(
          1,
          AoC.Day01.run_part_1("../data/01.txt"),
          AoC.Day01.run_part_2("../data/01.txt")
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
    state = {50, 0}

    data
    |> Enum.map(&parse_instruction/1)
    |> Enum.reduce(state, &spin/2)
    |> elem(1)
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    state = {50, 0}

    data
    |> Enum.map(&parse_instruction/1)
    |> Enum.reduce(state, &spin_0x434C49434B/2)
    |> elem(1)
  end

  @spec one_if_zero(position :: integer()) :: non_neg_integer()
  def one_if_zero(0), do: 1
  def one_if_zero(_), do: 0

  @spec parse_instruction(String.t()) ::
          {:ok, {:left | :right, non_neg_integer()}} | {:error, any()}
  def parse_instruction(str) do
    case Regex.run(~r/([LR])(\d+)/, str) do
      [_, "L", count] ->
        {:ok, {:left, String.to_integer(count)}}

      [_, "R", count] ->
        {:ok, {:right, String.to_integer(count)}}

      _ ->
        {:error, str}
    end
  end

  @spec spin(
          instruction :: {:ok, {:left | :right, non_neg_integer()}} | {:error, any()},
          state :: {integer(), non_neg_integer()}
        ) :: {integer(), non_neg_integer()}

  def spin({:ok, {:left, count}}, {position, zeros}) do
    new_position = position - count
    {new_position, zeros + one_if_zero(Integer.mod(new_position, 100))}
  end

  def spin({:ok, {:right, count}}, {position, zeros}) do
    new_position = position + count
    {new_position, zeros + one_if_zero(Integer.mod(new_position, 100))}
  end

  @spec spin_0x434C49434B(
          instruction :: {:ok, {:left | :right, non_neg_integer()}} | {:error, any()},
          state :: {integer(), non_neg_integer()}
        ) :: {integer(), non_neg_integer()}

  def spin_0x434C49434B({:ok, {_, 0}}, {position, zeros}) do
    {position, zeros}
  end

  def spin_0x434C49434B({:ok, {:left, count}}, {position, zeros}) do
    new_position = position - 1

    spin_0x434C49434B(
      {:ok, {:left, count - 1}},
      {new_position, zeros + one_if_zero(Integer.mod(new_position, 100))}
    )
  end

  def spin_0x434C49434B({:ok, {:right, count}}, {position, zeros}) do
    new_position = position + 1

    spin_0x434C49434B(
      {:ok, {:right, count - 1}},
      {new_position, zeros + one_if_zero(Integer.mod(new_position, 100))}
    )
  end
end
