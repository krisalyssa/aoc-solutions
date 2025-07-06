defmodule AoC do
  @moduledoc """
  Utility functions.
  """

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

    case Integer.mod(len, 2) do
      0 -> {left, right}
      1 -> {left, String.first(right), String.slice(right, 1..-1//1)}
    end
  end

  def bisect(list) when is_list(list) do
    len = Enum.count(list)
    half_len = Integer.floor_div(len, 2)

    case Integer.mod(len, 2) do
      0 -> {Enum.take(list, half_len), Enum.drop(list, half_len)}
      1 -> {Enum.take(list, half_len), [Enum.at(list, half_len)], Enum.drop(list, half_len + 1)}
    end
  end

  @doc ~S"""
  Print the solution for a day, in JSON format.

  ## Examples

      iex> AoC.print(1, 234, 567)
      {
        "day_01": [
          234,
          567
        ]
      }
  """
  @spec print(number() | String.t(), number() | String.t(), number() | String.t()) :: String.t()
  def print(day, s1, s2) do
    """
    {
      "day_#{day_str(day)}": [
        #{s1},
        #{s2}
      ]
    }
    """
  end

  defp day_str(d) when is_binary(d), do: d
  defp day_str(d), do: String.pad_leading("#{d}", 2, "0")
end
