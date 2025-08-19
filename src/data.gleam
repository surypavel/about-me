import gleam/time/calendar
import gleam/option.{Some, None, type Option}

pub type JobExperience {
  JobExperience(company: String, position: String, start_date: #(Int, calendar.Month), end_date: Option(#(Int, calendar.Month)), place_of_work: String, logo: String, technologies: List(String))
}

pub type Education {
  Education(degree: String, university: String, field: String, start_year: Int, end_year: Int, place_of_study: String, logo: String)
}

pub type Language {
  Language(name: String, emoji: String, level: String)
}

pub type Social {
  Social(name: String, url: String, logo: String)
}

pub type Skill {
  Skill(name: String, description: String, logo: String, major: Bool)
}

pub const job_experience_list = [
    JobExperience(
      "Rossum", 
      "Frontend Engineer", 
      #(2022, calendar.March),
      None, 
      "Prague, Czechia",
      "rossum",
      ["ts", "python"]
    ),
    JobExperience(
      "ITSCM GmbH", 
      "Javascript Engineer", 
      #(2020, calendar.October),
      Some(#(2022, calendar.April)),
      "Munich, Germany",
      "itscm",
      ["ts"]
    ),
    JobExperience(
      "Orchestr8", 
      "Frontend Engineer",
      #(2018, calendar.August),
      Some(#(2020, calendar.February)),
      "Prague, Czechia",
      "orchestr8",
      ["ts"]
    ),
    JobExperience(
      "Appio", 
      "Mobile Developer",
      #(2017, calendar.June),
      Some(#(2017, calendar.October)),
      "Prague, Czechia",
      "appio",
      ["csharp"]
    ),
    JobExperience(
      "Appio", 
      "PHP Developer",
      #(2013, calendar.November),
      Some(#(2017, calendar.January)),
      "Prague, Czechia",
      "appio",
      ["php", "js"]
    ),
]

pub const list_of_education = [
    Education(
      "Master's degree", 
      "Charles University", 
      "Mathematics for Information Technologies", 
      2017,
      2020,
      "Prague, Czechia",
      "uk"
    ),
    Education(
      "Bachelor's degree", 
      "Charles University", 
      "General Mathematics", 
      2014,
      2017,
      "Prague, Czechia",
      "uk"
    ),
]

pub const list_of_languages = [
    Language("Czech", "🇨🇿", "C2 (Native speaker)"),
    Language("English", "🇬🇧", "C2 (Cambridge certificate)"),
    Language("German", "🇩🇪", "B1 (approximate)"),
]

pub const list_of_skills = [
    Skill("Typescript", "Over 6 years of experience - most recently in React, but with earlier professional experience in Angular, Vue, and Express.", "ts", True),
    Skill("Python", "Experience with Python and Django after working on several Python-based codebases and university projects.", "python", True),
    Skill("Elixir", "Non-professional experience with Elixir, Phoenix and Ash framework and Gleam (used for numerous personal projects).", "elixir", True),
    Skill("PHP", "Over 5 years of experience (although very long ago) with PHP, Nette framework and Symfony framework.", "php", False),
    Skill("C#", "Few-month endeavour with mobile development using Xamarin framework and .NET backend.", "csharp", False),
]

pub const list_of_socials = [
    Social("GitHub", "https://github.com/surypavel/", "github"),
    Social("LinkedIn", "https://linkedin.com/in/pavelsury", "linkedin"),
]

