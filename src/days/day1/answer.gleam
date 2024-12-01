import gleam/bool
import gleam/int
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import simplifile

pub fn get_part1_answer() -> Int {
  let assert Ok(#(list1, list2)) = read_input_to_lists()

  let sorted1 = list.sort(list1, by: int.compare)
  let sorted2 = list.sort(list2, by: int.compare)

  int.sum(get_distances(sorted1, sorted2, []))
}

pub fn get_part2_answer() -> Int {
  let assert Ok(#(list1, list2)) = read_input_to_lists()

  get_similarity(list1, list2)
}

fn get_distances(
  list1: List(Int),
  list2: List(Int),
  current_distances: List(Int),
) -> List(Int) {
  case list1, list2 {
    [x, ..rest1], [y, ..rest2] ->
      get_distances(rest1, rest2, [
        int.absolute_value(x - y),
        ..current_distances
      ])
    _, _ -> current_distances
  }
}

fn get_similarity(list1: List(Int), list2: List(Int)) -> Int {
  list.fold(over: list1, from: 0, with: fn(acc: Int, target_element: Int) {
    acc
    + target_element
    * list.count(list2, where: fn(current_element: Int) {
      target_element == current_element
    })
  })
}

fn read_input_to_lists() -> Result(
  #(List(Int), List(Int)),
  simplifile.FileError,
) {
  simplifile.read("src/days/day1/input.txt")
  |> result.map(string.split(_, on: "\n"))
  |> result.map(list.filter(_, keeping: fn(string: String) {
    string
    |> string.is_empty
    |> bool.negate
  }))
  |> result.map(list.map(_, with: split_line))
  |> result.map(list.unzip)
}

fn split_line(line: String) -> #(Int, Int) {
  let assert Ok(pair) = string.split_once(line, "   ")

  parse_split_line(pair)
}

fn parse_split_line(pair: #(String, String)) -> #(Int, Int) {
  let assert Ok(first_int) = pair.first(pair) |> string.trim |> int.parse
  let assert Ok(second_int) = pair.second(pair) |> string.trim |> int.parse

  #(first_int, second_int)
}
