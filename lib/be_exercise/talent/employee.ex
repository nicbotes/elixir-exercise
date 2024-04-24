defmodule Exercise.Talent.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :full_name, :string
    field :job_title, :string
    field :salary, :decimal

    belongs_to :country, Exercise.Countries.Country
    belongs_to :payroll_currency, Exercise.Countries.Currency

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:full_name, :job_title, :salary, :country_id, :payroll_currency_id])
    |> validate_required([:full_name, :job_title, :salary])
    |> validate_number(:salary, greater_than_or_equal_to: 0)
  end
end
