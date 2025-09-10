import gleam/io
import gleam/json
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(data) = case simplifile.read("../data/01.txt") {
    Ok(raw_data) -> Ok(string.split(raw_data, on: "\n"))
    e -> Error(e)
  }

  let output = [
    #("day_01", json.array([
      part_1(data),
      part_2(data)
    ], of: json.int))
  ]
  |> json.object()
  |> json.to_string

  io.print(output)
}

pub fn part_1(data: List(String)) {
  let assert Ok(s) = list.first(data)
  let instructions = string.to_graphemes(s)
  list.fold(over: instructions, from: 0, with: fn(acc, i) {
    case i {
      "(" -> acc + 1
      ")" -> acc - 1
      _ -> acc
    }
  })
}

pub fn part_2(data: List(String)) {
  let assert Ok(s) = list.first(data)
  let instructions = list.index_map(string.to_graphemes(s), fn(g, idx) { #(idx, g) })
  list.fold_until(over: instructions, from: 0, with: fn(acc, inst) {
    case inst {
      #(_, "(") -> list.Continue(acc + 1)
      #(_, ")") if acc > 0 -> list.Continue(acc - 1)
      #(idx, _) -> list.Stop(idx + 1)
    }
  })
}
