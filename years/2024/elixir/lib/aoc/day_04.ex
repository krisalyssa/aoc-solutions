defmodule AoC.Day04 do
  @moduledoc false

  alias MatrixReloaded.Matrix

  @spec run() :: :ok
  def run, do: IO.puts(AoC.print(4, AoC.Day04.run_part_1("../data/04.txt"), AoC.Day04.run_part_2("../data/04.txt")))

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
    grid = data |> Enum.to_list() |> load_grid()

    [
      scan_bltr(grid),
      scan_brtl(grid),
      scan_bt(grid),
      scan_lr(grid),
      scan_rl(grid),
      scan_tb(grid),
      scan_tlbr(grid),
      scan_trbl(grid)
    ]
    |> Enum.sum()
  end

  @spec part_2(Enumerable.t()) :: integer()
  def part_2(data) do
    data
    |> Enum.to_list()
    |> load_grid()
    |> scan_xmas()
  end

  @spec corners(Matrix.t(), {integer(), integer()}) :: charlist()
  def corners(grid, {row, col}) do
    [
      Matrix.get_element(grid, {row - 1, col - 1}),
      Matrix.get_element(grid, {row - 1, col + 1}),
      Matrix.get_element(grid, {row + 1, col + 1}),
      Matrix.get_element(grid, {row + 1, col - 1})
    ]
    |> Enum.map(&elem(&1, 1))
  end

  @spec get_bltr(Matrix.t(), {integer(), integer()}) :: String.t()
  def get_bltr(grid, {row, col}) do
    [
      Matrix.get_element(grid, {row, col}),
      Matrix.get_element(grid, {row - 1, col + 1}),
      Matrix.get_element(grid, {row - 2, col + 2}),
      Matrix.get_element(grid, {row - 3, col + 3})
    ]
    |> Enum.map(&elem(&1, 1))
    |> to_string()
  end

  @spec get_brtl(Matrix.t(), {integer(), integer()}) :: String.t()
  def get_brtl(grid, {row, col}) do
    [
      Matrix.get_element(grid, {row, col}),
      Matrix.get_element(grid, {row - 1, col - 1}),
      Matrix.get_element(grid, {row - 2, col - 2}),
      Matrix.get_element(grid, {row - 3, col - 3})
    ]
    |> Enum.map(&elem(&1, 1))
    |> to_string()
  end

  @spec get_tlbr(Matrix.t(), {integer(), integer()}) :: String.t()
  def get_tlbr(grid, {row, col}) do
    [
      Matrix.get_element(grid, {row, col}),
      Matrix.get_element(grid, {row + 1, col + 1}),
      Matrix.get_element(grid, {row + 2, col + 2}),
      Matrix.get_element(grid, {row + 3, col + 3})
    ]
    |> Enum.map(&elem(&1, 1))
    |> to_string()
  end

  @spec get_trbl(Matrix.t(), {integer(), integer()}) :: String.t()
  def get_trbl(grid, {row, col}) do
    [
      Matrix.get_element(grid, {row, col}),
      Matrix.get_element(grid, {row + 1, col - 1}),
      Matrix.get_element(grid, {row + 2, col - 2}),
      Matrix.get_element(grid, {row + 3, col - 3})
    ]
    |> Enum.map(&elem(&1, 1))
    |> to_string()
  end

  @spec load_grid([String.t()]) :: Matrix.t()
  def load_grid(data) do
    cols = data |> List.first() |> String.length()

    {:ok, first_row} = Matrix.new({1, cols})

    {:ok, grid} =
      data
      |> Enum.map(&load_row/1)
      |> Enum.reduce(first_row, fn r, acc ->
        {:ok, new_acc} = Matrix.concat_col(acc, r)
        new_acc
      end)
      |> Matrix.drop_row(0)

    grid
  end

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

  @spec scan_bltr(Matrix.t()) :: integer()
  def scan_bltr(grid) do
    {rows, cols} = Matrix.size(grid)

    list = for r <- 3..(rows - 1), c <- 0..(cols - 3), into: [], do: {r, c}

    Enum.reduce(list, 0, fn index, acc -> acc + scan_line(get_bltr(grid, index)) end)
  end

  @spec scan_brtl(Matrix.t()) :: integer()
  def scan_brtl(grid) do
    {rows, cols} = Matrix.size(grid)

    list = for r <- 3..(rows - 1), c <- 3..(cols - 1), into: [], do: {r, c}

    Enum.reduce(list, 0, fn index, acc -> acc + scan_line(get_brtl(grid, index)) end)
  end

  @spec scan_bt(Matrix.t()) :: integer()
  def scan_bt(grid) do
    grid
    |> Matrix.flip_ud()
    |> Matrix.transpose()
    |> scan_lr()
  end

  @spec scan_line(String.t()) :: integer()
  def scan_line(line) do
    ~r/XMAS/
    |> Regex.scan(line)
    |> Enum.count()
  end

  @spec scan_lr(Matrix.t()) :: integer()
  def scan_lr(grid) do
    grid
    |> Enum.map(&to_string/1)
    |> Enum.map(&scan_line/1)
    |> Enum.sum()
  end

  @spec scan_rl(Matrix.t()) :: integer()
  def scan_rl(grid) do
    grid
    |> Matrix.flip_lr()
    |> Enum.map(&to_string/1)
    |> Enum.map(&scan_line/1)
    |> Enum.sum()
  end

  @spec scan_tb(Matrix.t()) :: integer()
  def scan_tb(grid) do
    grid
    |> Matrix.transpose()
    |> scan_lr()
  end

  @spec scan_tlbr(Matrix.t()) :: integer()
  def scan_tlbr(grid) do
    {rows, cols} = Matrix.size(grid)

    list = for r <- 0..(rows - 3), c <- 0..(cols - 3), into: [], do: {r, c}

    Enum.reduce(list, 0, fn index, acc -> acc + scan_line(get_tlbr(grid, index)) end)
  end

  @spec scan_trbl(Matrix.t()) :: integer()
  def scan_trbl(grid) do
    {rows, cols} = Matrix.size(grid)

    list = for r <- 0..(rows - 3), c <- 3..(cols - 1), into: [], do: {r, c}

    Enum.reduce(list, 0, fn index, acc -> acc + scan_line(get_trbl(grid, index)) end)
  end

  @spec scan_xmas(Matrix.t()) :: integer()
  def scan_xmas(grid) do
    {rows, cols} = Matrix.size(grid)

    list = for r <- 1..(rows - 2), c <- 1..(cols - 2), into: [], do: {r, c}

    list
    |> Enum.map(fn index ->
      {:ok, element} = Matrix.get_element(grid, index)
      {index, element}
    end)
    |> Enum.filter(fn {_, element} -> element == ?A end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(&corners(grid, &1))
    |> Enum.count(&x?/1)
  end

  @spec x?(charlist()) :: boolean()
  def x?(~c"MMSS"), do: true
  def x?(~c"SMMS"), do: true
  def x?(~c"SSMM"), do: true
  def x?(~c"MSSM"), do: true
  def x?(_), do: false
end
