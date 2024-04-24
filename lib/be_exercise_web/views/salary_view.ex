defmodule ExerciseWeb.SalaryView do
  use ExerciseWeb, :view

  def render("index.json", %{summary: summary}) do
    %{data: summary}
  end
end
