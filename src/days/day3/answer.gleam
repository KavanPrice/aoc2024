import gleam/bool
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/regexp
import gleam/result
import gleam/string
import simplifile

pub fn get_part1_answer() -> Int {
  let assert Ok(lines) = read_input_to_lines()

  lines
  |> list.map(get_line_value)
  |> int.sum
}

fn read_input_to_lines() -> Result(List(String), simplifile.FileError) {
  simplifile.read("src/days/day3/input.txt")
  |> result.map(string.split(_, on: "\n"))
  |> result.map(list.filter(_, keeping: fn(string: String) {
    string
    |> string.is_empty
    |> bool.negate
  }))
}

fn get_line_value(line: String) -> Int {
  let assert Ok(re) = regexp.from_string("mul\\(\\d{1,3},\\d{1,3}\\)")
  regexp.scan(re, line)
  |> list.map(fn(mul_match) {
    let assert Ok(re) = regexp.from_string("\\d{1,3}")
    regexp.scan(re, mul_match.content)
    |> list.fold(from: 1, with: fn(acc, number_match) {
      let assert Ok(value) = int.parse(number_match.content)
      acc * value
    })
  })
  |> int.sum
}
