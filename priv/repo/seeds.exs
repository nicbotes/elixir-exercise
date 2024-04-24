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

Code.require_file("fake_data.ex", __DIR__)
Code.require_file("seed.ex", __DIR__)
alias Exercise.Repo.Seed

{time_in_microseconds, _result} = :timer.tc(fn ->
  {:ok, currency_ids} = Seed.currencies!()
  {:ok, country_ids} = Seed.countries!()

  Seed.generate_bulk_employee_dataset(country_ids, currency_ids)
  |> Seed.bulk_insert_employees()
end)

import Ecto.Query, warn: false
seed_employee_count = from(e in Exercise.Talent.Employee, select: max(e.id)) |> Exercise.Repo.one
seed_country_count = from(e in Exercise.Countries.Country, select: max(e.id)) |> Exercise.Repo.one
seed_currency_count = from(e in Exercise.Countries.Currency, select: max(e.id)) |> Exercise.Repo.one

IO.puts(~s"""
\n\n
Seeding Report
--------------
Countries:    #{seed_country_count}
Currencies:   #{seed_currency_count}
Employees:    #{seed_employee_count}
Time taken:   #{round(time_in_microseconds / 1_000)} ms

Seeding Complete.
""")
