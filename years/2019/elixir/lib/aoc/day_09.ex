defmodule AoC.Day09 do
  @moduledoc false

  alias AoC.Intcode.{Interpreter, Memory}

  def run do
    IO.puts("day 09 part 1: #{AoC.Day09.part_1("../data/09.txt")}")
    IO.puts("day 09 part 2: #{AoC.Day09.part_2("../data/09.txt")}")
  end

  def part_1(filename) do
    {:ok, agent} = Agent.start_link(fn -> [] end)
    output_fn = fn value -> Agent.update(agent, fn buffer -> [buffer, value] end) end
    memory = Memory.load_from_file(filename)

    vm =
      Task.async(Interpreter, :initialize, [
        %{state: :running, memory: memory, output_fn: output_fn}
      ])

    send(vm.pid, 1)
    {:halt, %{state: :stopped}} = Task.await(vm, :infinity)

    output =
      agent
      |> Agent.get(fn value -> value end)
      |> List.flatten()

    Agent.stop(agent)

    List.first(output)
  end

  def part_2(filename) do
    {:ok, agent} = Agent.start_link(fn -> [] end)
    output_fn = fn value -> Agent.update(agent, fn buffer -> [buffer, value] end) end
    memory = Memory.load_from_file(filename)

    vm =
      Task.async(Interpreter, :initialize, [
        %{state: :running, memory: memory, output_fn: output_fn}
      ])

    send(vm.pid, 2)
    {:halt, %{state: :stopped}} = Task.await(vm, :infinity)

    output =
      agent
      |> Agent.get(fn value -> value end)
      |> List.flatten()

    Agent.stop(agent)

    List.first(output)
  end
end
