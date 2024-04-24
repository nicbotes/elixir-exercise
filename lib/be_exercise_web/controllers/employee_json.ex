defmodule ExerciseWeb.EmployeeJSON do
  alias Exercise.Talent.Employee

  @doc """
  Renders a list of employees.
  """
  def index(%{employees: employees}) do
    %{data: for(employee <- employees, do: data(employee))}
  end

  @doc """
  Renders a single employee.
  """
  def show(%{employee: employee}) do
    %{data: data(employee)}
  end

  defp data(%Employee{} = employee) do
    %{
      id: employee.id,
      full_name: employee.full_name,
      job_title: employee.job_title,
      salary: employee.salary
    }
  end
end
