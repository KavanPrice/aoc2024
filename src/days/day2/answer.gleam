import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import simplifile

pub fn get_part1_answer() -> Int {
  let assert Ok(reports) = read_input_to_reports()

  list.count(reports, report_is_safe)
}

fn read_input_to_reports() -> Result(List(List(Int)), simplifile.FileError) {
  simplifile.read("src/days/day2/input.txt")
  |> result.map(string.split(_, on: "\n"))
  |> result.map(list.filter(_, keeping: fn(string: String) {
    string
    |> string.is_empty
    |> bool.negate
  }))
  |> result.map(list.map(_, with: split_line))
}

fn split_line(line: String) -> List(Int) {
  line
  |> string.split(" ")
  |> parse_split_line
}

fn parse_split_line(report_strings: List(String)) -> List(Int) {
  report_strings
  |> list.map(string.trim)
  |> list.map(int.parse)
  |> result.values
}

fn report_is_safe(report: List(Int)) -> Bool {
  { report_is_increasing(report) || report_is_decreasing(report) }
  && report_obeys_level_difference_rule(report)
}

fn report_is_increasing(report: List(Int)) -> Bool {
  list.sort(report, by: int.compare) == report && list.unique(report) == report
}

fn report_is_decreasing(report: List(Int)) -> Bool {
  report |> list.sort(by: int.compare) |> list.reverse == report
  && list.unique(report) == report
}

fn report_obeys_level_difference_rule(report: List(Int)) -> Bool {
  report
  |> get_adjacent_pairs
  |> list.all(fn(pair) {
    let absolute_difference =
      int.absolute_value(pair.first(pair) - pair.second(pair))

    absolute_difference > 0 && absolute_difference < 4
  })
}

fn get_adjacent_pairs(list: List(Int)) -> List(#(Int, Int)) {
  list.index_map(list, fn(x, i) { #(i, x) })
  |> list.combination_pairs
  |> list.filter_map(fn(pair) {
    let #(#(i1, x1), #(i2, x2)) = pair
    case i1 + 1 == i2 {
      True -> Ok(#(x1, x2))
      False -> Error(Nil)
    }
  })
}
