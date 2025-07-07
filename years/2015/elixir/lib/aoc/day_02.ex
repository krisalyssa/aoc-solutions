defmodule AoC.Day02 do
  @moduledoc false

  @spec run() :: :ok
  def run,
    do:
      IO.puts(
        AoC.print(
          2,
          AoC.Day02.run_part_1("../data/02.txt"),
          AoC.Day02.run_part_2("../data/02.txt")
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
    data
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn d -> Map.put(d, :surface_area, surface_area(d)) end)
    |> Enum.map(fn d -> Map.put(d, :smallest_side, smallest_side(d)) end)
    |> Enum.map(fn d -> Map.get(d, :surface_area) + Map.get(d, :smallest_side) end)
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn d -> Map.put(d, :ribbon, smallest_perimeter(d)) end)
    |> Enum.map(fn d -> Map.put(d, :bow, volume(d)) end)
    |> Enum.map(fn d -> Map.get(d, :ribbon) + Map.get(d, :bow) end)
    |> Enum.sum()
  end

  @spec parse_line(String.t()) :: %{String.t() => integer()}
  def parse_line(line) do
    ~r/(?<length>\d+)x(?<width>\d+)x(?<height>\d+)/
    |> Regex.named_captures(line)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), String.to_integer(v)} end)
    |> Map.new()
  end

  def smallest_perimeter(dimensions),
    do: Enum.min([perimeter_lh(dimensions), perimeter_lw(dimensions), perimeter_wh(dimensions)])

  def smallest_side(dimensions),
    do: Enum.min([side_lh(dimensions), side_lw(dimensions), side_wh(dimensions)])

  def surface_area(dimensions),
    do: 2 * side_lh(dimensions) + 2 * side_lw(dimensions) + 2 * side_wh(dimensions)

  def volume(%{length: l, width: w, height: h}), do: l * w * h

  defp perimeter_lh(%{length: l, height: h}), do: 2 * l + 2 * h
  defp perimeter_lw(%{length: l, width: w}), do: 2 * l + 2 * w
  defp perimeter_wh(%{width: w, height: h}), do: 2 * w + 2 * h

  defp side_lh(%{length: l, height: h}), do: l * h
  defp side_lw(%{length: l, width: w}), do: l * w
  defp side_wh(%{width: w, height: h}), do: w * h
end
