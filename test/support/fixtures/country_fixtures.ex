defmodule Exercise.CountryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exercise.Talent` context.
  """

  alias Exercise.Countries

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    unique_suffix = :erlang.unique_integer([:positive, :monotonic])

    defaults = %{
      name: "Country#{unique_suffix}",
      code: "C#{unique_suffix}"
    }

    params = Map.merge(defaults, attrs)

    {:ok, country} = Countries.create_country(params)
    country
  end
end
