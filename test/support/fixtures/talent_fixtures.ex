defmodule Exercise.TalentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exercise.Talent` context.
  """

  alias Exercise.Talent

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    country = Exercise.CountryFixtures.country_fixture()
    currency = Exercise.CurrencyFixtures.currency_fixture()

    {:ok, employee} =
      attrs
      |> Enum.into(%{
        full_name: "some full_name",
        job_title: "some job_title",
        salary: "120.5",
        country_id: country.id,
        payroll_currency_id: currency.id,
      })
      |> Talent.create_employee()

    employee
  end
end
