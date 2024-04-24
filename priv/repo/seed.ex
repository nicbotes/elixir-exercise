# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Exercise.Repo.insert!(%Exercise.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
# The code below demonstrates initial data insertion for currencies and countries.
# Please feel free to update the code if you consider it necessary.

defmodule Exercise.Repo.Seed do
  alias Exercise.Countries
  alias Exercise.Repo
  alias Exercise.Talent.Employee
  alias FakeData.{Work, Names, Geofinance}

  @batch_write_size 1_000

  def bulk_insert_employees(employee_attrs) do
    employee_attrs
    |> Enum.chunk_every(@batch_write_size)
    |> Enum.each(fn batch ->
      Repo.insert_all(Employee, batch)
    end)
  end

  def generate_bulk_employee_dataset(country_ids, currency_ids, number_of_job_titles \\ 100, number_of_records \\ 10_000) do
    generated_at = DateTime.utc_now() |> DateTime.to_naive() |> NaiveDateTime.truncate(:second)
    jobs = Work.job_titles(number_of_job_titles)
    names = Names.full_names(number_of_records)

    for name <- names do
      [job, country_id, currency_id] = [
        Enum.take_random(jobs, 1),
        Enum.take_random(country_ids, 1),
        Enum.take_random(currency_ids, 1)
        ] |> List.flatten

      %{
        full_name: "#{name}",
        job_title: job,
        salary: :rand.uniform(100_000),
        country_id: country_id,
        payroll_currency_id: currency_id,
        inserted_at: generated_at,
        updated_at: generated_at
      }
    end
  end

  def currencies! do
    currency_ids = for currency <- Geofinance.currencies() do
      [name, code, symbol] = currency

      {:ok, currency} = Countries.create_currency(%{
        name: name,
        code: code,
        symbol: symbol
      })
      %{id: id} = currency
      id
    end

    {:ok, currency_ids}
  end

  # Seed the 12 supported countries
  def countries! do
    country_ids = for country <- Geofinance.countries() do
      [name, code, currency_code] = country
      currency = Countries.get_currency_by_code!(currency_code)

      {:ok, country} = Countries.create_country(%{
        name: name,
        code: code,
        currency_id: currency.id
      })
      %{id: id} = country
      id
    end

    {:ok, country_ids}
  end
end
