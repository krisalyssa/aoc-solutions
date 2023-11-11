defmodule AoC.Day01 do
  @moduledoc false

  def run do
    IO.puts("day 01 part 1: #{AoC.Day01.part_1("../data/01.txt")}")
    IO.puts("day 01 part 2: #{AoC.Day01.part_2("../data/01.txt")}")
  end

  def part_1(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&calculate_fuel/1)
    |> Enum.reduce(0, &(&1 + &2))
  end

  def part_2(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&calculate_all_fuel/1)
    |> Enum.reduce(0, &(&1 + &2))
  end

  def calculate_fuel(mass), do: Integer.floor_div(mass, 3) - 2

  def calculate_all_fuel(mass) do
    case calculate_fuel(mass) do
      fuel_mass when fuel_mass > 0 -> fuel_mass + calculate_all_fuel(fuel_mass)
      _ -> 0
    end
  end
end
