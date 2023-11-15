public struct Day01: DayRunner {
  public init() {
  }

  public func run() {
    part1()
    part2()
  }

  public func part1() {
    print("Hello from Day01.part1()")
  }

  public func part2() {
    print("Hello from Day01.part2()")
  }

  func calculateFuel(mass: Int) -> Int {
    return (mass / 3) - 2
  }

  func calculateAllFuel() {

  }

  //   def calculate_fuel(mass), do: Integer.floor_div(mass, 3) - 2

  //   def calculate_all_fuel(mass) do
  //     case calculate_fuel(mass) do
  //       fuel_mass when fuel_mass > 0 -> fuel_mass + calculate_all_fuel(fuel_mass)
  //       _ -> 0
  //     end
  //   end

}
