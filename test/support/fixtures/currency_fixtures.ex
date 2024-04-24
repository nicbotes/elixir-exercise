defmodule Exercise.CurrencyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exercise.Talent` context.
  """

alias Exercise.Countries

  @doc """
  Generate a country.
  """
  def currency_fixture(attrs \\ %{}) do
    unique_suffix = :erlang.unique_integer([:positive, :monotonic])

    defaults = %{
      code: "C#{unique_suffix}D",
      name: "Country#{unique_suffix} Dollar",
      symbol: "$#{unique_suffix}"
    }

    params = Map.merge(defaults, attrs)

    {:ok, currency} = Countries.create_currency(params)
    currency
  end
end
