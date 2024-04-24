defmodule ExerciseWeb.EmployeeController do
  use ExerciseWeb, :controller

  alias Exercise.Talent
  alias Exercise.Talent.Employee

  action_fallback ExerciseWeb.FallbackController

  def index(conn, _params) do
    employees = Talent.list_employees([:payroll_currency, :country])
    render(conn, "index.json", employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- Talent.create_employee(employee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/employees/#{employee}")
      |> render("create_or_update.json", employee: employee)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Talent.get_employee!(id, [:payroll_currency, :country])
    render(conn, "show.json", employee: employee)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Talent.get_employee!(id)

    with {:ok, %Employee{} = employee} <- Talent.update_employee(employee, employee_params) do
      render(conn, "create_or_update.json", employee: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Talent.get_employee!(id)

    with {:ok, %Employee{}} <- Talent.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end
end
