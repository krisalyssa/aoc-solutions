defmodule AoC.Day06 do
  @moduledoc false

  alias MatrixReloaded.Matrix

  @spec run() :: :ok
  def run do
    IO.puts("day 06 part 1: #{AoC.Day06.run_part_1("../data/06.txt")}")
    IO.puts("day 06 part 2: #{AoC.Day06.run_part_2("../data/06.txt")}")
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
    |> Enum.map(&String.trim/1)
    |> load_grid()
    |> walk()
    |> elem(0)
    |> List.flatten()
    |> Enum.count(fn c -> c == ?X end)
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.count()
  end

  @spec index_grid(Matrix.t()) :: [{number(), {number(), number()}}]
  def index_grid(grid) do
    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, m} ->
      row
      |> Enum.with_index(fn element, n -> {element, {m, n}} end)
    end)
    |> List.flatten()
  end

  def load_grid(data) do
    grid = AoC.load_grid(data)

    {_, starting_position} =
      grid
      |> index_grid()
      |> Enum.find(fn {c, _} -> c == ?^ end)

    {:ok, grid_without_guard} = Matrix.update_element(grid, ?., starting_position)
    {grid_without_guard, {starting_position, :north}}
  end

  def step({grid, {index, _heading} = state}) do
    {max_m, max_n} = Matrix.size(grid)

    {:ok, visited_grid} = Matrix.update_element(grid, ?X, index)
    {_, rotated_heading} = rotated_state = rotate(state, collision?(grid, state))
    {{new_m, new_n}, _} = new_state = {move(rotated_state), rotated_heading}

    if new_m < 0 || new_n < 0 || new_m >= max_m || new_n >= max_n do
      {visited_grid, {{new_m, new_n}, :exited}}
    else
      {:ok, updated_grid} =
        Matrix.update_element(visited_grid, guard(rotated_heading), {new_m, new_n})

      {updated_grid, new_state}
    end
  end

  def walk({_, {_, :exited}} = grid_and_state), do: grid_and_state
  def walk({grid, state}), do: walk(step({grid, state}))

  defp collision?(_, {{0, _}, :north}) do
    false
  end

  defp collision?(_, {{_, 0}, :west}) do
    false
  end

  defp collision?(grid, {{m, n}, heading} = state) do
    {max_m, max_n} = Matrix.size(grid)

    if (heading == :east && m + 1 >= max_m) || (heading == :south && n + 1 >= max_n) do
      false
    else
      Matrix.get_element(grid, move(state)) == {:ok, ?#}
    end
  end

  defp guard(:north), do: ?^
  defp guard(:east), do: ?>
  defp guard(:south), do: ?v
  defp guard(:west), do: ?<

  defp move({{m, n}, :north}), do: {m - 1, n}
  defp move({{m, n}, :south}), do: {m + 1, n}
  defp move({{m, n}, :east}), do: {m, n + 1}
  defp move({{m, n}, :west}), do: {m, n - 1}

  defp rotate({index, :north}, true), do: {index, :east}
  defp rotate({index, :east}, true), do: {index, :south}
  defp rotate({index, :south}, true), do: {index, :west}
  defp rotate({index, :west}, true), do: {index, :north}
  defp rotate(state, false), do: state
end
