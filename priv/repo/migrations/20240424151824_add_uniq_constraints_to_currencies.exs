defmodule Exercise.Repo.Migrations.AddUniqConstraintsToCurrencies do
  use Ecto.Migration

  def change do
    create unique_index(:currencies, [:name])
    create unique_index(:currencies, [:code])
  end
end
