defmodule AoC do
  @moduledoc """
  Utility functions.
  """
  require Integer

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
end
