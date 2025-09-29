import gleam/io
import gleam/json
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(data) = case simplifile.read("../data/04.txt") {
    Ok(raw_data) -> Ok(string.split(raw_data, on: "\n"))
    e -> Error(e)
  }

  let output =
    [#("day_04", json.array([part_1(data), part_2(data)], of: json.int))]
    |> json.object()
    |> json.to_string

  io.print(output)
}

fn part_1(data: List(String)) {
  list.length(data)
}

fn part_2(data: List(String)) {
  list.length(data)
}
