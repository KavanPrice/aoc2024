import days/day1/answer as day1
import days/day2/answer as day2
import days/day3/answer as day3
import gleam/dict
import gleam/int
import gleam/io
import gleam/pair

pub fn main() {
  dict.from_list([
    #(#(1, 1), day1.get_part1_answer),
    #(#(1, 2), day1.get_part2_answer),
    #(#(2, 1), day2.get_part1_answer),
    #(#(2, 2), day2.get_part2_answer),
    #(#(3, 1), day3.get_part1_answer),
    #(#(3, 2), day3.get_part2_answer),
  ])
  |> get_all_answers
  |> print_all_answers
}

fn get_all_answers(
  day_func_map: dict.Dict(#(Int, Int), fn() -> Int),
) -> dict.Dict(#(Int, Int), Int) {
  day_func_map
  |> dict.map_values(with: fn(_: #(Int, Int), func: fn() -> Int) { func() })
}

fn print_all_answers(day_answer_map: dict.Dict(#(Int, Int), Int)) {
  day_answer_map
  |> dict.each(print_answer)
}

fn print_answer(day_part: #(Int, Int), answer: Int) -> Nil {
  io.println(
    "Day "
    <> int.to_string(pair.first(day_part))
    <> " part "
    <> int.to_string(pair.second(day_part))
    <> " answer: "
    <> int.to_string(answer),
  )
}
