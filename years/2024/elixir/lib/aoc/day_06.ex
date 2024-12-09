defmodule AoC.Day06 do
  @moduledoc false

  alias MatrixReloaded.Matrix

  @type index :: {integer(), integer()}

  defmodule State do
    @moduledoc false

    defstruct [:index, :heading, :visited]

    @type heading :: :north | :east | :south | :west | :exited

    @type t :: %__MODULE__{
            index: AoC.Day06.index(),
            heading: heading(),
            visited: %{{AoC.Day06.index(), :heading} => boolean()}
          }
  end

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

  @spec index_grid(Matrix.t()) :: [{number(), index()}]
  def index_grid(grid) do
    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, m} ->
      row
      |> Enum.with_index(fn element, n -> {element, {m, n}} end)
    end)
    |> List.flatten()
  end

  @spec load_grid([String.t()]) :: {Matrix.t(), State.t()}
  def load_grid(data) do
    grid = AoC.load_grid(data)

    {_, starting_position} =
      grid
      |> index_grid()
      |> Enum.find(fn {c, _} -> c == ?^ end)

    {:ok, grid_without_guard} = Matrix.update_element(grid, ?., starting_position)
    {grid_without_guard, %State{index: starting_position, heading: :north, visited: %{}}}
  end

  @spec step({Matrix.t(), State.t()}) :: {Matrix.t(), State.t()}
  def step({grid, state}) do
    {max_m, max_n} = Matrix.size(grid)

    {visited_grid, visited_state} = visit({grid, state})

    new_heading = rotate(state, collision?(visited_grid, visited_state)).heading
    {new_m, new_n} = new_index = move(%State{visited_state | heading: new_heading})

    if new_m < 0 || new_n < 0 || new_m >= max_m || new_n >= max_n do
      {visited_grid, %{visited_state | index: {new_m, new_n}, heading: :exited}}
    else
      {:ok, updated_grid} = Matrix.update_element(visited_grid, guard(new_heading), new_index)

      {updated_grid, %State{visited_state | index: new_index, heading: new_heading}}
    end
  end

  @spec walk({Matrix.t(), State.t()}) :: {Matrix.t(), State.t()}
  def walk({_, %State{heading: :exited}} = grid_and_state), do: grid_and_state
  def walk({grid, state}), do: walk(step({grid, state}))

  defp collision?(_, %State{index: {0, _}, heading: :north}) do
    false
  end

  defp collision?(_, %State{index: {_, 0}, heading: :west}) do
    false
  end

  defp collision?(grid, %State{index: {m, n}, heading: heading} = state) do
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

  defp move(%State{index: {m, n}, heading: :north}), do: {m - 1, n}
  defp move(%State{index: {m, n}, heading: :south}), do: {m + 1, n}
  defp move(%State{index: {m, n}, heading: :east}), do: {m, n + 1}
  defp move(%State{index: {m, n}, heading: :west}), do: {m, n - 1}

  defp rotate(%State{heading: :north} = state, true), do: %State{state | heading: :east}
  defp rotate(%State{heading: :east} = state, true), do: %State{state | heading: :south}
  defp rotate(%State{heading: :south} = state, true), do: %State{state | heading: :west}
  defp rotate(%State{heading: :west} = state, true), do: %State{state | heading: :north}
  defp rotate(state, false), do: state

  defp visit({grid, %State{index: index, heading: heading, visited: visited} = state}) do
    {:ok, updated_grid} = Matrix.update_element(grid, ?X, index)
    updated_visited = Map.put(visited, {index, heading}, true)
    {updated_grid, %State{state | visited: updated_visited}}
  end
end
