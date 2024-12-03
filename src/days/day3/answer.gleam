import gleam/int
import gleam/list
import gleam/regexp
import gleam/string
import simplifile

pub fn get_part1_answer() -> Int {
  let assert Ok(input_string) = read_input_to_string()

  input_string
  |> get_line_value
}

pub fn get_part2_answer() -> Int {
  let assert Ok(input_string) = read_input_to_string()

  input_string
  |> get_line_value_with_instructions
}

fn read_input_to_string() -> Result(String, simplifile.FileError) {
  simplifile.read("src/days/day3/input.txt")
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

fn get_line_value_with_instructions(line: String) -> Int {
  string.split(line, on: "do()")
  |> list.map(string.split(_, on: "don't()"))
  |> list.filter_map(fn(sublist) { list.first(sublist) })
  |> string.join(with: "")
  |> get_line_value
}
