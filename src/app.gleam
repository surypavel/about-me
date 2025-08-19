import lustre
import lustre/element.{text, type Element}
import lustre/element/html.{div, p, h1, h2, ul, li, img, a}
import lustre/attribute.{class, style, title, src, href, target}
import gleam/list
import gleam/option.{Some, None, type Option}
import gleam/time/timestamp
import gleam/time/calendar
import gleam/time/duration
import gleam/int
import gleam/pair
import data.{type JobExperience, type Education, type Language, type Social, type Skill, job_experience_list, list_of_education, list_of_languages, list_of_skills, list_of_socials}
import timestamp_difference.{timestamp_difference}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) {
  0
} 

fn update(model, msg) {
}

fn view_job_experience(job_experience: JobExperience) -> Element(msg) {
  li([class("py-3 flex flex-row items-center space-x-4 relative justify-between")], [
    div([class("shrink-0 grow-0")], [
      div([class("bg-white bg-contain w-12 h-12 sm:w-24 sm:h-24 rounded-full bg-no-repeat bg-center"), style("background-image", "url(./priv/static/logo/" <> job_experience.logo <> ".png)")], [])
    ]),
    div([class("ml-4 grow-1 sm:grow-0 sm:min-w-60 overflow-hidden")], [
      p([class("text-xl font-medium text-black truncate")], [text(job_experience.company)]),
      p([class("text-md text-slate-800 truncate")], [text(job_experience.position)]),
      p([class("text-md text-stone-500 truncate")], [text(timestamp_difference(job_experience.start_date, job_experience.end_date))]),
      p([class("text-md text-stone-500 truncate")], [text(job_experience.place_of_work)]),
    ]),
    div([class("shrink-0 grow-1 hidden sm:flex flex-row space-x-2")], job_experience.technologies |> list.map(fn (technology) {
      div([class("bg-contain opacity-80 hover:opacity-90 w-6 h-6"), style("background-image", "url(./priv/static/lang/" <> technology <> ".png)")], [])
    })),
    div([class("relative h-[100px] w-10 shrink-0")], [
      p([class("text-sm text-stone-400 font-semibold truncate absolute bottom-[-12px] right-0")], [text(int.to_string(job_experience.start_date |> pair.first))]),
      p([class("absolute top-0 right-4 h-20 border-r border-stone-400 border-dashed")], []),
    ])
  ])
}

fn view_education(education: Education, is_last: Bool) -> Element(msg) {
  let append = case is_last {
    False -> []
    True -> [p([class("text-sm text-stone-400 font-semibold truncate absolute top-[-32px] right-0")], [text(int.to_string(education.end_year))])]
  }

  li([class("py-3 flex flex-row items-center space-x-4")], [
    div([class("shrink-0")], [
      div([class("bg-white bg-contain w-12 h-12 sm:w-24 sm:h-24 rounded-full bg-no-repeat bg-center"), style("background-image", "url(./priv/static/logo/" <> education.logo <> ".png)")], [])
    ]),
    div([class("ml-4 shrink-1 grow-1 overflow-hidden")], [
      p([class("text-xl font-medium text-black truncate")], [text(education.university)]),
      p([class("text-md text-slate-800 truncate"), title(education.field)], [text(education.field)]),
      p([class("text-md text-stone-500 truncate"), title(education.degree)], [text(education.degree)]),
      p([class("text-md text-stone-500 truncate"), title(education.place_of_study)], [text(education.place_of_study)]),
    ]),
    div([class("relative h-[100px] w-10 shrink-0")], [
      p([class("text-sm text-stone-400 font-semibold truncate absolute bottom-[-12px] right-0")], [text(int.to_string(education.start_year))]),
      p([class("absolute top-0 right-4 h-20 border-r border-stone-400 border-dashed")], []),
      ..append
    ])
  ])
}

fn view(_model) {
  div([], [
    div([class("bg-white border-t-4 border-stone-100")], [
      div([class("container max-w-150 mx-auto flex flex-col gap-4 items-center")], [
        img([class("w-full max-w-150 mt-20 pl-5"), src("./priv/static/xxgenwhite.jpeg")]),
        h1([class("text-cyan-600 opacity-80 text-5xl pb-20 pt-0 font-[Rancho]")], [text("Pavel Surý")]),
      ])
    ]),
    div([class("bg-white px-10 py-10")], [
      div([class("container max-w-170 mx-auto flex flex-col sm:flex-row items-center gap-8")], [
        div([class("flex flex-col gap-4")], [
          h2([class("text-stone-800 text-3xl")], [text("About")]),
          p([class("text-slate-800 text-2xl")], [text("I am a software engineer with experience with Typescript, Python and Elixir.")]),
          p([class("text-stone-500 text-md")], [text("I like maths and cats.")]),
        ]),
        div([class("w-40 h-40 shrink-0 rounded-full bg-no-repeat bg-center bg-cover"), style("background-image", "url(./priv/static/photo/me_2.png)")], [])
      ]),
    ]),
    div([class("bg-stone-50 px-10 py-10")], [
      div([class("container max-w-170 mx-auto flex flex-col gap-4")], [
        h2([class("text-stone-800 text-3xl")], [text("Experience")]),
        ul([], 
          list.map(job_experience_list, view_job_experience)
        )
      ])
    ]),
    div([class("bg-stone-100 px-10 py-10")], [
      div([class("container max-w-170 mx-auto flex flex-col gap-4")], [
        h2([class("text-stone-800 text-3xl")], [text("Education")]),
        ul([], 
          list.index_map(list_of_education, fn (education, index) {
            view_education(education, index == 0)
          })
        )
      ])
    ]),
    div([class("bg-stone-50 px-10 py-10")], [
      div([class("container max-w-170 mx-auto flex flex-col gap-4")], [
        h2([class("text-stone-800 text-3xl")], [text("Languages")]),
        ul([], 
          list.map(list_of_languages, fn (language: Language) {
            li([class("py-2 flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-4")], [
              div([class("flex flex-row items-center gap-2 min-w-[160px]")], [
                p([class("text-slate-800 text-3xl")], [text(language.emoji)]),
                p([class("text-slate-800 text-xl")], [text(language.name)]),
              ]),
              p([class("text-stone-500 text-md")], [text(language.level)]),
            ])
          })
        )
      ])
    ]),
    div([class("bg-stone-100 px-10 py-10")], [
      div([class("container max-w-170 mx-auto flex flex-col gap-4")], [
        h2([class("text-stone-800 text-3xl")], [text("Major skills")]),
        ul([], 
          list_of_skills |> list.filter(fn (skill: Skill) {
            skill.major == True
          }) |> list.map(fn (skill: Skill) {
            li([class("py-2 flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-4")], [
              div([class("flex flex-row items-center gap-2 min-w-[160px]")], [
                img([class("w-6 h-6"), src("./priv/static/lang/" <> skill.logo <> ".png")]),
                p([class("text-slate-800 text-xl")], [text(skill.name)]),
              ]),
              p([class("text-stone-500 text-md")], [text(skill.description)]),
            ])
          })
        ),
        h2([class("text-stone-800 text-2xl")], [text("Minor skills")]),
        ul([], 
          list_of_skills |> list.filter(fn (skill: Skill) {
            skill.major == False
          }) |> list.map(fn (skill: Skill) {
            li([class("py-2 flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-4")], [
              div([class("flex flex-row items-center gap-2 min-w-[160px]")], [
                img([class("w-6 h-6"), src("./priv/static/lang/" <> skill.logo <> ".png")]),
                p([class("text-slate-800 text-xl")], [text(skill.name)]),
              ]),
              p([class("text-stone-500 text-md")], [text(skill.description)]),
            ])
          })
        )

      ])
    ]),
    div([class("bg-stone-900 px-10 py-10")], [
      div([class("container max-w-170 mx-auto flex flex-col gap-4")], [
        h2([class("text-stone-100 text-3xl")], [text("Socials")]),
        ul([], 
          list.map(list_of_socials, fn (social: Social) {
            li([class("py-2 flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-4")], [
              div([class("flex flex-row items-center gap-2")], [
                img([class("w-6 h-6"), src("./priv/static/social/" <> social.logo <> ".png")]),
                p([class("text-slate-100 text-xl min-w-[90px]")], [text(social.name)]),
              ]),
              a([class("text-stone-500 text-md hover:text-stone-100 transition-colors duration-200"), href(social.url), target("_blank")], [text(social.url)]),
            ])
          })
        )
      ])
    ])
  ])
}