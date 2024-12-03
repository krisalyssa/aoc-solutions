defmodule AoC.Day01 do
  @moduledoc false

  def run do
    IO.puts("day 01 part 1: #{AoC.Day01.run_part_1("../data/01.txt")}")
    IO.puts("day 01 part 2: #{AoC.Day01.run_part_2("../data/01.txt")}")
  end

  def run_part_1(filename) do
    filename
    |> File.stream!()
    |> part_1()
  end

  def run_part_2(filename) do
    filename
    |> File.stream!()
    |> part_2()
  end

  @spec part_1(Enumerable.t()) :: integer() | String.t()
  def part_1(data) do
    instructions =
      data
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, ~r/[,\s]+/))
      |> List.flatten()

    starting_state = {:north, {0, 0}}

    expanded_instructions =
      instructions
      |> Enum.map(fn instruction ->
        <<direction::8>> <> steps = instruction
        expand(<<direction>>, steps)
      end)
      |> List.flatten()

    {_, final_coordinates} =
      expanded_instructions
      |> Enum.reduce(starting_state, fn instruction, {heading, coordinates} ->
        case instruction do
          "S" -> {heading, step(heading, coordinates)}
          t -> {turn(heading, t), coordinates}
        end
      end)

    distance(final_coordinates)
  end

  @spec part_2(Enumerable.t()) :: integer() | String.t()
  def part_2(data) do
    instructions =
      data
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, ~r/[,\s]+/))
      |> List.flatten()

    starting_state = {:north, {0, 0}, MapSet.new([{0, 0}])}

    expanded_instructions =
      instructions
      |> Enum.map(fn instruction ->
        <<direction::8>> <> steps = instruction
        expand(<<direction>>, steps)
      end)
      |> List.flatten()

    final_coordinates =
      expanded_instructions
      |> Enum.reduce_while(starting_state, fn instruction, {heading, coordinates, history} ->
        case instruction do
          "S" ->
            new_coordinates = step(heading, coordinates)

            update_history_if_unvisited(
              MapSet.member?(history, new_coordinates),
              {heading, new_coordinates, history}
            )

          t ->
            {:cont, {turn(heading, t), coordinates, history}}
        end
      end)

    distance(final_coordinates)
  end

  @spec distance({integer(), integer()}) :: integer()
  def distance({x, y}), do: abs(x) + abs(y)

  @spec expand(String.t(), String.t() | integer()) :: [String.t()]
  def expand(direction, steps_str) when is_binary(steps_str) do
    {steps, _} = Integer.parse(steps_str)
    expand(direction, steps)
  end

  def expand(direction, steps) do
    [direction, List.duplicate("S", steps)]
  end

  @spec walk(:north | :east | :south | :west, {integer(), integer()}, String.t() | integer()) ::
          {integer(), integer()}
  def walk(heading, coordinates, steps_str) when is_binary(steps_str) do
    {steps, _} = Integer.parse(steps_str)
    walk(heading, coordinates, steps)
  end

  def walk(_heading, coordinates, 0) do
    coordinates
  end

  def walk(heading, coordinates, steps) do
    new_coordinates = step(heading, coordinates)
    walk(heading, new_coordinates, steps - 1)
  end

  defp step(heading, {x, y}) do
    case heading do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  defp turn(:north, "L"), do: :west
  defp turn(:east, "L"), do: :north
  defp turn(:south, "L"), do: :east
  defp turn(:west, "L"), do: :south

  defp turn(:north, "R"), do: :east
  defp turn(:east, "R"), do: :south
  defp turn(:south, "R"), do: :west
  defp turn(:west, "R"), do: :north

  defp update_history_if_unvisited(true, {_heading, coordinates, _history}),
    do: {:halt, coordinates}

  defp update_history_if_unvisited(false, {heading, coordinates, history}),
    do: {:cont, {heading, coordinates, MapSet.put(history, coordinates)}}
end
