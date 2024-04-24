defmodule ExerciseWeb.EmployeeView do
  use ExerciseWeb, :view
  alias ExerciseWeb.EmployeeView
  alias ExerciseWeb.CountryView
  alias ExerciseWeb.CurrencyView

  def render("index.json", %{employees: employees}) do
    %{data: render_many(employees, EmployeeView, "employee.json")}
  end

  def render("employee.json", %{employee: employee}) do
    %{
      id: employee.id,
      full_name: employee.full_name,
      job_title: employee.job_title,
      salary: employee.salary,
      country: maybe_render_country(employee),
      payroll_currency: maybe_render_currency(employee)
    }
  end

  def render("employee_without_associations.json", %{employee: employee}) do
    %{
      id: employee.id,
      full_name: employee.full_name,
      job_title: employee.job_title,
      salary: employee.salary,
      country_id: employee.country_id,
      payroll_currency_id: employee.payroll_currency_id
    }
  end

  def render("show.json", %{employee: employee}) do
    %{data: render_one(employee, EmployeeView, "employee.json")}
  end

  def render("create_or_update.json", %{employee: employee}) do
    %{data: render_one(employee, EmployeeView, "employee_without_associations.json")}
  end

  defp maybe_render_country(%{country: country, country_id: country_id}) when not is_nil(country_id) do
    render_one(country, CountryView, "country.json")
  end
  defp maybe_render_country(_), do: nil

  defp maybe_render_currency(%{payroll_currency_id: currency_id, payroll_currency: currency}) when not is_nil(currency_id) do
    render_one(currency, CurrencyView, "currency.json")
  end
  defp maybe_render_currency(_), do: nil
end
