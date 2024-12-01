import days/day1
import gleam/dict
import gleam/int
import gleam/io

pub fn main() {
  dict.from_list([#(1, day1.get_answer)])
  |> get_all_answers
  |> print_all_answers
}

fn get_all_answers(
  day_func_map: dict.Dict(Int, fn() -> Int),
) -> dict.Dict(Int, Int) {
  day_func_map
  |> dict.map_values(with: fn(_: Int, func: fn() -> Int) { func() })
}

fn print_all_answers(day_answer_map: dict.Dict(Int, Int)) {
  day_answer_map
  |> dict.each(print_answer)
}

fn print_answer(day: Int, answer: Int) -> Nil {
  io.println(
    "Day " <> int.to_string(day) <> " answer: " <> int.to_string(answer),
  )
}
