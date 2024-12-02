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
    {_, coordinates} =
      data
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, ~r/[,\s]+/))
      |> List.flatten()
      |> Enum.reduce({:north, {0, 0}}, fn instruction, {heading, coordinates} ->
        {new_heading, new_coordinates} =
          case instruction do
            "L" <> steps ->
              new_heading =
                case heading do
                  :north -> :west
                  :east -> :north
                  :south -> :east
                  :west -> :south
                end

              {new_heading, move(coordinates, new_heading, steps)}

            "R" <> steps ->
              new_heading =
                case heading do
                  :north -> :east
                  :east -> :south
                  :south -> :west
                  :west -> :north
                end

              {new_heading, move(coordinates, new_heading, steps)}
          end

        {new_heading, new_coordinates}
      end)

    distance(coordinates)
  end

  @spec distance({integer(), integer()}) :: integer()
  def distance({x, y}), do: abs(x) + abs(y)

  @spec move({integer(), integer()}, :north | :east | :south | :west, String.t()) ::
          {integer(), integer()}
  def move({x, y}, heading, steps_str) do
    {steps, _} = Integer.parse(steps_str)

    case heading do
      :north -> {x, y + steps}
      :east -> {x + steps, y}
      :south -> {x, y - steps}
      :west -> {x - steps, y}
    end
  end

  @spec part_2(Enumerable.t()) :: integer() | String.t()
  def part_2(data) do
    data
    |> Enum.count()
  end
end
