defmodule AoC.Day05 do
  @moduledoc false

  alias AoC.Intcode.{Interpreter, Memory}

  def run do
    IO.puts("day 05 part 1: #{AoC.Day05.part_1("../data/05.txt")}")
    IO.puts("day 05 part 2: #{AoC.Day05.part_2("../data/05.txt")}")
  end

  def part_1(filename) do
    {:ok, agent} = Agent.start_link(fn -> nil end)
    output_fn = fn value -> Agent.update(agent, fn _ -> value end) end
    memory = Memory.load_from_file(filename)

    vm =
      Task.async(Interpreter, :initialize, [
        %{state: :running, memory: memory, output_fn: output_fn}
      ])

    send(vm.pid, 1)
    {:halt, %{state: :stopped}} = Task.await(vm)

    result = Agent.get(agent, fn value -> value end)
    Agent.stop(agent)

    result
  end

  def part_2(filename) do
    {:ok, agent} = Agent.start_link(fn -> nil end)
    output_fn = fn value -> Agent.update(agent, fn _ -> value end) end
    memory = Memory.load_from_file(filename)

    vm =
      Task.async(Interpreter, :initialize, [
        %{state: :running, memory: memory, output_fn: output_fn}
      ])

    send(vm.pid, 5)
    {:halt, %{state: :stopped}} = Task.await(vm)

    result = Agent.get(agent, fn value -> value end)
    Agent.stop(agent)

    result
  end
end
