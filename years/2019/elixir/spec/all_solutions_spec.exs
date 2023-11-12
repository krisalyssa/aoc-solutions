defmodule AllSolutions.Spec do
  @moduledoc false

  use ESpec

  example_group "day 01" do
    it "part 1" do
      expect(AoC.Day01.part_1("../data/01.txt"))
      |> to(eq(3_303_995))
    end

    it "part 2" do
      expect(AoC.Day01.part_2("../data/01.txt"))
      |> to(eq(4_953_118))
    end
  end

  example_group "day 02" do
    it "part 1" do
      expect(AoC.Day02.part_1("../data/02.txt"))
      |> to(eq(7_594_646))
    end

    it "part 2" do
      expect(AoC.Day02.part_2("../data/02.txt"))
      |> to(eq(3376))
    end
  end

  example_group "day 03" do
    it "part 1" do
      expect(AoC.Day03.part_1("../data/03.txt"))
      |> to(eq(399))
    end

    it "part 2" do
      expect(AoC.Day03.part_2("../data/03.txt"))
      |> to(eq(15678))
    end
  end

  example_group "day 04" do
    it "part 1" do
      expect(AoC.Day04.part_1("../data/04.txt"))
      |> to(eq(1169))
    end

    it "part 2" do
      expect(AoC.Day04.part_2("../data/04.txt"))
      |> to(eq(757))
    end
  end

  example_group "day 05" do
    it "part 1" do
      expect(AoC.Day05.part_1("../data/05.txt"))
      |> to(eq(9_025_675))
    end

    it "part 2" do
      expect(AoC.Day05.part_2("../data/05.txt"))
      |> to(eq(11_981_754))
    end
  end

  example_group "day 06" do
    it "part 1" do
      expect(AoC.Day06.part_1("../data/06.txt"))
      |> to(eq(245_089))
    end

    it "part 2" do
      expect(AoC.Day06.part_2("../data/06.txt"))
      |> to(eq(511))
    end
  end

  example_group "day 07" do
    it "part 1" do
      expect(AoC.Day07.part_1("../data/07.txt"))
      |> to(eq(13848))
    end

    it "part 2" do
      expect(AoC.Day07.part_2("../data/07.txt"))
      |> to(eq(12_932_154))
    end
  end

  example_group "day 08" do
    it "part 1" do
      expect(AoC.Day08.part_1("../data/08.txt"))
      |> to(eq(2176))
    end

    it "part 2" do
      expect(AoC.Day08.part_2("../data/08.txt"))
      |> to(eq("CYKBY"))
    end
  end

  example_group "day 09" do
    it "part 1" do
      expect(AoC.Day09.part_1("../data/09.txt"))
      |> to(eq(3_742_852_857))
    end

    it "part 2" do
      expect(AoC.Day09.part_2("../data/09.txt"))
      |> to(eq(73439))
    end
  end

  example_group "day 10" do
    it "part 1" do
      expect(AoC.Day10.part_1("../data/10.txt"))
      |> to(eq(278))
    end

    it "part 2" do
      expect(AoC.Day10.part_2("../data/10.txt"))
      |> to(eq(1417))
    end
  end

  example_group "day 11" do
    it "part 1" do
      expect(AoC.Day11.part_1("../data/11.txt"))
      |> to(eq(2268))
    end

    it "part 2" do
      expect(AoC.Day11.part_2("../data/11.txt"))
      |> to(eq("CEPKZJCR"))
    end
  end

  example_group "day 12" do
    it "part 1" do
      expect(AoC.Day12.part_1("../data/12.txt"))
      |> to(eq(9958))
    end

    it "part 2" do
      expect(AoC.Day12.part_2("../data/12.txt"))
      |> to(eq(318_382_803_780_324))
    end
  end

  example_group "day 13" do
    it "part 1" do
      expect(AoC.Day13.part_1("../data/13.txt"))
      |> to(eq(284))
    end

    it "part 2" do
      expect(AoC.Day13.part_2("../data/13.txt"))
      |> to(eq(13581))
    end
  end

  example_group "day 14" do
    it "part 1" do
      expect(AoC.Day14.part_1("../data/14.txt"))
      |> to(eq(1_967_319))
    end

    it "part 2" do
      expect(AoC.Day14.part_2("../data/14.txt"))
      |> to(eq(1_122_036))
    end
  end

  example_group "day 15" do
    it "part 1" do
      expect(AoC.Day15.part_1("../data/15.txt"))
      |> to(eq(300))
    end

    it "part 2" do
      expect(AoC.Day15.part_2("../data/15.txt"))
      |> to(eq(312))
    end
  end

  example_group "day 16" do
    it "part 1" do
      expect(AoC.Day16.part_1("../data/16.txt"))
      |> to(eq(52_611_030))
    end

    it "part 2" do
      expect(AoC.Day16.part_2("../data/16.txt"))
      |> to(eq(52_541_026))
    end
  end

  example_group "day 17" do
    it "part 1" do
      expect(AoC.Day17.part_1("../data/17.txt"))
      |> to(eq(6672))
    end

    it "part 2" do
      expect(AoC.Day17.part_2("../data/17.txt"))
      |> to(eq(923_017))
    end
  end

  example_group "day 18" do
  end
end
