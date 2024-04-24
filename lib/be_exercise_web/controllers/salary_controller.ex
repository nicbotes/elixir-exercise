defmodule ExerciseWeb.SalaryController do
  use ExerciseWeb, :controller

  alias Exercise.Talent

  action_fallback ExerciseWeb.FallbackController

  def index(conn, params) do
    {:ok, payload} = case params do
      %{"job_title" => job_title} -> Talent.employee_salary_stats_by_job_title(job_title)
      %{"country" => country} -> Talent.employee_salary_stats_by_country(country)
      _ -> {:ok, nil}
    end

    render(conn, "index.json", summary: payload)
  end
end
