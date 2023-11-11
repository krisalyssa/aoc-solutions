defmodule AllSolutions.Spec do
  @moduledoc false

  use ESpec

  example_group "day 01" do
    it "part 1" do
      expect(AoC.Day01.part_1("../data/01.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_01") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day01.part_2("../data/01.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_01") |> List.last()))
    end
  end

  example_group "day 02" do
    it "part 1" do
      expect(AoC.Day02.part_1("../data/02.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_02") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day02.part_2("../data/02.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_02") |> List.last()))
    end
  end

  example_group "day 03" do
    it "part 1" do
      expect(AoC.Day03.part_1("../data/03.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_03") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day03.part_2("../data/03.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_03") |> List.last()))
    end
  end

  example_group "day 04" do
    it "part 1" do
      expect(AoC.Day04.part_1("../data/04.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_04") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day04.part_2("../data/04.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_04") |> List.last()))
    end
  end

  example_group "day 05" do
    it "part 1" do
      expect(AoC.Day05.part_1("../data/05.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_05") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day05.part_2("../data/05.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_05") |> List.last()))
    end
  end

  example_group "day 06" do
    it "part 1" do
      expect(AoC.Day06.part_1("../data/06.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_06") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day06.part_2("../data/06.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_06") |> List.last()))
    end
  end

  example_group "day 07" do
    it "part 1" do
      expect(AoC.Day07.part_1("../data/07.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_07") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day07.part_2("../data/07.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_07") |> List.last()))
    end
  end

  example_group "day 08" do
    it "part 1" do
      expect(AoC.Day08.part_1("../data/08.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_08") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day08.part_2("../data/08.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_08") |> List.last()))
    end
  end

  example_group "day 09" do
    it "part 1" do
      expect(AoC.Day09.part_1("../data/09.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_09") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day09.part_2("../data/09.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_09") |> List.last()))
    end
  end

  example_group "day 10" do
    it "part 1" do
      expect(AoC.Day10.part_1("../data/10.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_10") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day10.part_2("../data/10.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_10") |> List.last()))
    end
  end

  example_group "day 11" do
    it "part 1" do
      expect(AoC.Day11.part_1("../data/11.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_11") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day11.part_2("../data/11.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_11") |> List.last()))
    end
  end

  example_group "day 12" do
    it "part 1" do
      expect(AoC.Day12.part_1("../data/12.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_12") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day12.part_2("../data/12.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_12") |> List.last()))
    end
  end

  example_group "day 13" do
    it "part 1" do
      expect(AoC.Day13.part_1("../data/13.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_13") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day13.part_2("../data/13.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_13") |> List.last()))
    end
  end

  example_group "day 14" do
    it "part 1" do
      expect(AoC.Day14.part_1("../data/14.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_14") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day14.part_2("../data/14.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_14") |> List.last()))
    end
  end

  example_group "day 15" do
    it "part 1" do
      expect(AoC.Day15.part_1("../data/15.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_15") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day15.part_2("../data/15.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_15") |> List.last()))
    end
  end

  example_group "day 16" do
    it "part 1" do
      expect(AoC.Day16.part_1("../data/16.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_16") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day16.part_2("../data/16.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_16") |> List.last()))
    end
  end

  example_group "day 17" do
    it "part 1" do
      expect(AoC.Day17.part_1("../data/17.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_17") |> List.first()))
    end

    it "part 2" do
      expect(AoC.Day17.part_2("../data/17.txt"))
      |> to(eq(shared.solutions |> Map.fetch!("day_17") |> List.last()))
    end
  end

  example_group "day 18" do
  end
end
