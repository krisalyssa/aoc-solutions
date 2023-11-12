defmodule AoC.Day16 do
  @moduledoc false

  def run do
    IO.puts("day 16 part 1: #{AoC.Day16.part_1("../data/16.txt")}")
    IO.puts("day 16 part 2: #{AoC.Day16.part_2("../data/16.txt")}")
  end

  def part_1(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.join("")
    |> split_signal()
    |> checksum(100)
  end

  def part_2(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.join("")
    |> split_signal()
    |> extract_embedded_message()
  end

  def checksum(input, n) do
    1..n
    |> Enum.reduce(input, fn _, signal -> dither_signal(signal) end)
    |> Enum.take(8)
    |> Enum.map(fn digit -> "#{digit}" end)
    |> Enum.join()
    |> String.to_integer()
  end

  def dither_signal(input) do
    {dithered, _} =
      Enum.map_reduce(input, 1, fn _, index -> {dither_with_offset(input, index), index + 1} end)

    dithered
  end

  def dither_with_offset(input, offset) do
    offset
    |> get_dither_pattern()
    |> Enum.zip(input)
    |> Enum.reduce(0, fn {a, b}, acc -> acc + a * b end)
    |> abs()
    |> Integer.mod(10)
  end

  def embedded_message_offset(input) do
    input
    |> Enum.take(7)
    |> Enum.join()
    |> String.to_integer()
  end

  def extract_embedded_message(one_instance) do
    one_length = Enum.count(one_instance)
    total_length = one_length * 10_000
    offset = embedded_message_offset(one_instance)
    count_backwards = total_length - offset

    reversed =
      one_instance
      |> Enum.reverse()
      |> List.duplicate(div(count_backwards, one_length) + 1)
      |> List.flatten()
      |> Enum.take(count_backwards)

    processed =
      Enum.reduce(1..100, reversed, fn _, input ->
        {output, _} =
          Enum.map_reduce(input, 0, fn digit, acc ->
            new_digit = Integer.mod(acc + digit, 10)
            {new_digit, new_digit}
          end)

        output
      end)

    processed
    |> Enum.reverse()
    |> Enum.take(8)
    |> Enum.join()
    |> String.to_integer()
  end

  def get_dither_pattern(n) when n in [0, 1] do
    [0, 1, 0, -1]
    |> Stream.cycle()
    |> Stream.drop(1)
  end

  def get_dither_pattern(n) do
    [0, 1, 0, -1]
    |> Enum.map(&List.duplicate(&1, n))
    |> List.flatten()
    |> Stream.cycle()
    |> Stream.drop(1)
  end

  def split_signal(input) do
    input
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
