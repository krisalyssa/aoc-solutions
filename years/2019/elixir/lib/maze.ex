defmodule Maze do
  @moduledoc ~S"""
  Borrowed heavily from https://github.com/jamis/weekly-challenges/blob/master/003-maze-solver/hard-mode.ex
  """

  defstruct cells: MapSet.new(),
            keys: %{},
            found_keys: MapSet.new(),
            doors: %{},
            start_pos: {0, 0},
            accumulated_path: []

  def from_file(filename) do
    filename
    |> File.stream!()
    |> from_lines()
  end

  def from_lines(lines) do
    lines
    |> Enum.reduce([], fn line, acc -> [String.to_charlist(line) | acc] end)
    |> Enum.reverse()
    |> build_maze(%Maze{}, 0)
  end

  def find_shortest_path(maze) do
    maze
    |> paths_to_remaining_keys(maze.start_pos)
    |> visit_next_key(nil)
  end

  def visit_next_key([], shortest_path), do: shortest_path

  def visit_next_key([{maze, key, path} | rest], shortest_path) do
    new_maze =
      maze
      |> move_to(path)
      |> pick_up_key(key)
      |> open_door(key)

    next_paths = paths_to_remaining_keys(new_maze, new_maze.start_pos)

    cond do
      !Enum.empty?(next_paths) ->
        next_paths
        |> Kernel.++(rest)
        |> visit_next_key(shortest_path)

      is_nil(shortest_path) || Enum.count(new_maze.accumulated_path) < Enum.count(shortest_path) ->
        visit_next_key(rest, new_maze.accumulated_path)

      true ->
        visit_next_key(rest, shortest_path)
    end
  end

  defp add_to_frontier(pos, list, true), do: MapSet.put(list, pos)
  defp add_to_frontier(_, list, false), do: list

  defp build_maze([], maze, _), do: maze

  defp build_maze([line | rest], maze, row),
    do: build_maze(rest, parse_line(line, maze, row, 0), row + 1)

  defp check_frontier(pos, maze, distances, list),
    do:
      add_to_frontier(pos, list, MapSet.member?(maze.cells, pos) && !Map.has_key?(distances, pos))

  defp find_path(maze, start_pos, end_pos) do
    [start_pos]
    |> step(maze, MapSet.new(), 0, %{}, end_pos)
    |> Enum.drop(1)
  end

  defp frontier_for(pos, maze, distances, list),
    do:
      Enum.reduce(neighbors(pos), list, fn p, acc -> check_frontier(p, maze, distances, acc) end)

  defp key_to_door(key), do: String.upcase(key)

  defp move_to(maze, path),
    do: %{maze | start_pos: Enum.at(path, -1), accumulated_path: maze.accumulated_path ++ path}

  defp neighbors({row, col}), do: [{row - 1, col}, {row + 1, col}, {row, col - 1}, {row, col + 1}]

  defp open_door(%{cells: cells, doors: doors} = maze, key) do
    door = key_to_door(key)
    door_pos = Map.get(doors, door)
    %{maze | cells: MapSet.put(cells, door_pos), doors: Map.delete(doors, door)}
  end

  defp parse_line([], maze, _, _), do: maze

  defp parse_line([char | rest], maze, row, col),
    do: parse_line(rest, process_char(char, maze, {row, col}), row, col + 1)

  defp paths_to_remaining_keys(maze, start_pos) do
    maze.keys
    |> Enum.map(fn {letter, end_pos} -> {maze, letter, find_path(maze, start_pos, end_pos)} end)
    |> Enum.reject(fn {_, _, path} -> Enum.empty?(path) end)
  end

  defp pick_up_key(%{keys: keys, found_keys: found_keys} = maze, key),
    do: %{maze | keys: Map.delete(keys, key), found_keys: MapSet.put(found_keys, key)}

  defp process_char(?#, maze, _), do: maze

  defp process_char(?@, maze, pos),
    do: %{maze | cells: MapSet.put(maze.cells, pos), start_pos: pos}

  defp process_char(char, maze, pos) when char in ?a..?z,
    do: %{
      maze
      | cells: MapSet.put(maze.cells, pos),
        keys: Map.put(maze.keys, <<char::utf8>>, pos)
    }

  defp process_char(char, maze, pos) when char in ?A..?Z,
    do: %{maze | doors: Map.put(maze.doors, <<char::utf8>>, pos)}

  defp process_char(_, maze, pos), do: %{maze | cells: MapSet.put(maze.cells, pos)}

  defp step([], maze, frontier, _, distances, end_pos) when frontier == %MapSet{} do
    if Map.has_key?(distances, end_pos) do
      trace_path(end_pos, maze.start_pos, distances, [])
    else
      []
    end
  end

  defp step([], maze, frontier, distance, distances, end_pos),
    do: step(MapSet.to_list(frontier), maze, MapSet.new(), distance + 1, distances, end_pos)

  defp step([pos | rest], maze, frontier, distance, distances, end_pos) do
    {frontier, distances} =
      case Map.has_key?(distances, pos) do
        true -> {frontier, distances}
        false -> {frontier_for(pos, maze, distances, frontier), Map.put(distances, pos, distance)}
      end

    step(rest, maze, frontier, distance, distances, end_pos)
  end

  defp trace_path(current, initial, _, path) when current == initial, do: [initial | path]

  defp trace_path(current, initial, distances, path) do
    distance = Map.get(distances, current)
    neighbor = Enum.find(neighbors(current), fn n -> Map.get(distances, n) == distance - 1 end)
    trace_path(neighbor, initial, distances, [current | path])
  end
end
