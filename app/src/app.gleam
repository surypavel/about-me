import gleam/int
import lustre
import lustre/element.{text, type Element}
import lustre/element/html.{div, button, p, h1, h2, ul, li}
import lustre/event.{on_click}
import lustre/attribute.{class}
import gleam/list
import gleam/option.{Some, None, type Option}

pub type JobExperience {
  JobExperience(company: String, position: String, start_date: String, end_date: Option(String), place_of_work: String)
}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) {
  0
} 

type Msg {
  Incr
  Decr
}

fn update(model, msg) {
  case msg {
    Incr -> model + 1
    Decr -> model - 1
  }
}

fn view_job_experience(job_experience: JobExperience) -> Element(msg) {
  let date_range = case job_experience.end_date {
    Some(end_date) -> [job_experience.start_date, " to ", end_date]
    None -> ["Since ", job_experience.start_date]
  }
  
  li([class("pb-3 sm:pb-4")], [
    p([class("text-lg font-medium text-gray-900 truncate dark:text-white")], [text(job_experience.company)]),
    p([class("text-md text-gray-500 truncate dark:text-gray-400")], [text(job_experience.position)]),
    p([class("text-md text-gray-500 truncate dark:text-gray-400")], [text(date_range)]),
    p([class("text-md text-gray-500 truncate dark:text-gray-400")], [text(job_experience.place_of_work)]),
  ])
}

fn view(model) {
  let count = int.to_string(model)

  let job_experience_list = [
    JobExperience("Rossum", "Frontend Engineer", "2022-03-01", None, "Prague, Czechia"),
    JobExperience("ITSCM GmbH", "Javascript Engineer", "2021-01-01", Some("2022-01-01"), "Munich, Germany"),
    JobExperience("Orchestr8", "Javascript Engineer", "2021-01-01", Some("2022-01-01"), "Prague, Czechia"),
  ]

  div([], [
    div([], [
      div([class("container mx-auto flex flex-col gap-4 items-center")], [
        h1([class("text-slate-600 text-5xl p-10 mt-50")], [text("Pavel Surý")]),
      ])
    ]),
    div([class("bg-cyan-50 px-10")], [
      div([class("container mx-auto flex flex-col gap-4")], [
        h2([class("text-cyan-500 text-3xl pt-10")], [text("About")]),
        p([class("text-cyan-800 text-2xl")], [text("I am a software engineer with a passion for building scalable and maintainable applications.")]),
      ]),
      div([class("container mx-auto flex flex-col gap-4")], [
        h2([class("text-cyan-500 text-3xl pt-10")], [text("Experience")]),
        ul([class("max-w-md divide-y divide-gray-200")], 
          list.map(job_experience_list, view_job_experience)
        )
      ])
    ])
  ])
}