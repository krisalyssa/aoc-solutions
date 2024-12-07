defmodule AoC do
  @moduledoc """
  Utility functions.
  """
  require Integer

  alias MatrixReloaded.Matrix

  @doc """
  Split something in half, if it makes sense to be able to split it.

  ## Examples

      iex> AoC.bisect("ABCDEF")
      {"ABC", "DEF"}

      iex> AoC.bisect("ABCDE")
      {"AB", "C", "DE"}

      iex> AoC.bisect("")
      {"", ""}

      iex> AoC.bisect([1, 2, 3, 4, 5, 6])
      {[1, 2, 3], [4, 5, 6]}

      iex> AoC.bisect([1, 2, 3, 4, 5])
      {[1, 2], [3], [4, 5]}

      iex> AoC.bisect([])
      {[], []}
  """
  def bisect(str) when is_binary(str) do
    len = String.length(str)
    {left, right} = String.split_at(str, Integer.floor_div(len, 2))

    if Integer.is_even(len) do
      {left, right}
    else
      {left, String.first(right), String.slice(right, 1..-1//1)}
    end
  end

  def bisect(list) when is_list(list) do
    len = Enum.count(list)
    half_len = Integer.floor_div(len, 2)

    if Integer.is_even(len) do
      {Enum.take(list, half_len), Enum.drop(list, half_len)}
    else
      {Enum.take(list, half_len), [Enum.at(list, half_len)], Enum.drop(list, half_len + 1)}
    end
  end

  @doc """
  Create a matrix from an array of Strings.

  The MatrixReloaded module only stores numbers, but characters can be stored as numbers.
  """
  @spec load_grid([String.t()]) :: Matrix.t()
  def load_grid(data), do: load_grid(data, &load_row/1)

  @spec load_grid([String.t()], (String.t() -> Matrix.t())) :: Matrix.t()
  def load_grid(data, load_row) do
    cols = data |> List.first() |> String.length()

    {:ok, first_row} = Matrix.new({1, cols})

    {:ok, grid} =
      data
      |> Enum.map(&load_row.(&1))
      |> Enum.reduce(first_row, fn r, acc ->
        {:ok, new_acc} = Matrix.concat_col(acc, r)
        new_acc
      end)
      |> Matrix.drop_row(0)

    grid
  end

  @doc """
  Create a 1xN matrix from a String.

  The MatrixReloaded module only stores numbers, but characters can be stored as numbers.
  """
  @spec load_row(String.t()) :: Matrix.t()
  def load_row(str) do
    {:ok, row} = Matrix.new({1, String.length(str)})

    str
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(row, fn {c, index}, acc ->
      value = c |> String.to_charlist() |> List.first()
      {:ok, new_acc} = Matrix.update_element(acc, value, {0, index})
      new_acc
    end)
  end
end
