defmodule Maze.Spec do
  @moduledoc false

  use ESpec

  describe "playground" do
    it do
      maze =
        [
          "#########",
          "#b.A.@.a#",
          "#########"
        ]
        |> Maze.from_lines()

      expect(Enum.count(Maze.find_shortest_path(maze))) |> to(eq(8))
    end

    it do
      maze =
        [
          "########################",
          "#f.D.E.e.C.b.A.@.a.B.c.#",
          "######################.#",
          "#d.....................#",
          "########################"
        ]
        |> Maze.from_lines()

      expect(Enum.count(Maze.find_shortest_path(maze))) |> to(eq(86))
    end

    it do
      maze =
        [
          "########################",
          "#...............b.C.D.f#",
          "#.######################",
          "#.....@.a.B.c.d.A.e.F.g#",
          "########################"
        ]
        |> Maze.from_lines()

      expect(Enum.count(Maze.find_shortest_path(maze))) |> to(eq(132))
    end

    xit do
      maze =
        [
          "#################",
          "#i.G..c...e..H.p#",
          "########.########",
          "#j.A..b...f..D.o#",
          "########@########",
          "#k.E..a...g..B.n#",
          "########.########",
          "#l.F..d...h..C.m#",
          "#################"
        ]
        |> Maze.from_lines()

      expect(Enum.count(Maze.find_shortest_path(maze))) |> to(eq(136))
    end

    it do
      maze =
        [
          "########################",
          "#@..............ac.GI.b#",
          "###d#e#f################",
          "###A#B#C################",
          "###g#h#i################",
          "########################"
        ]
        |> Maze.from_lines()

      expect(Enum.count(Maze.find_shortest_path(maze))) |> to(eq(81))
    end
  end

  example_group "from_lines/1" do
    it do
      maze =
        [
          "#########",
          "#b.A.@.a#",
          "#########"
        ]
        |> Maze.from_lines()

      expect(maze.start_pos) |> to(eq({1, 5}))
      expect(maze.keys) |> to(eq(%{"a" => {1, 7}, "b" => {1, 1}}))
      expect(maze.doors) |> to(eq(%{"A" => {1, 3}}))
      expect(maze.cells) |> to(eq(MapSet.new([{1, 1}, {1, 2}, {1, 4}, {1, 5}, {1, 6}, {1, 7}])))
    end
  end
end
