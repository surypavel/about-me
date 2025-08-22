import gleam/int
import gleam/option.{type Option, None, Some}
import gleam/pair
import gleam/time/calendar
import gleam/time/duration
import gleam/time/timestamp

fn years_and_months_between(
  start_date: calendar.Date,
  finish_date: calendar.Date,
) -> #(Int, Int) {
  let years_diff = finish_date.year - start_date.year
  let months_diff =
    calendar.month_to_int(finish_date.month)
    - calendar.month_to_int(start_date.month)
    + 1

  case months_diff < 0 {
    True -> #(years_diff - 1, months_diff + 12)
    False -> #(years_diff, months_diff)
  }
}

pub fn timestamp_difference(
  start_date: #(Int, calendar.Month),
  end_date: Option(#(Int, calendar.Month)),
) -> String {
  let start_date_calendar = calendar.Date(start_date.0, start_date.1, 1)
  let end_date_calendar = case end_date {
    Some(end_date) -> calendar.Date(end_date.0, end_date.1, 1)
    None ->
      timestamp.system_time()
      |> timestamp.to_calendar(duration.seconds(0))
      |> pair.first
  }

  let diff = years_and_months_between(start_date_calendar, end_date_calendar)
  let years = diff.0
  let months = diff.1

  case years > 0 {
    True -> int.to_string(years) <> " yrs " <> int.to_string(months) <> " mos"
    False -> int.to_string(months) <> " mos"
  }
}
