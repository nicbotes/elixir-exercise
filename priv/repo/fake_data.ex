defmodule FakeData do
  @moduledoc """
  A generator of fake data
  """

  @doc """
  Read dataset from a single column file
  """
  def read_vector(file_name) do
    File.read!(file_name)
    |> String.split("\n", trim: true)
  end
end

defmodule FakeData.Geofinance do
  @doc """
  Generate currency data.

  All available currencies are returned by default, unless a desired number is given.
  """
  def currencies(list_length \\ -1) do
    currency_data()
    |> subset_of(list_length)
  end

  @doc """
  Generate country data.

  All available countries are returned by default, unless a desired number is given.
  """
  def countries(list_length \\ -1) do
    country_data()
    |> subset_of(list_length)
  end

  defp subset_of(source, list_length \\ -1) do
    case {list_length} do
      {x} when x < 0 -> source
      {x} when x >= 0 -> source |> Enum.take_random(list_length)
    end
  end

  defp country_data do
    [
      ["Australia", "AUS", "AUD"],
      ["Canada", "CAN", "CAD"],
      ["France", "FRA", "EUR"],
      ["Japan", "JPN", "JPY"],
      ["Italy", "ITA", "EUR"],
      ["Liechtenstein", "LIE", "CHF"],
      ["New Zealand", "NZL", "NZD"],
      ["Portugal", "PRT", "EUR"],
      ["Spain", "ESP", "EUR"],
      ["Switzerland", "CHE", "CHF"],
      ["United Kingdom", "GBR", "GBP"],
      ["United States", "USA", "USD"]
    ]
  end

  # Seed the 8 supported currencies
  # Euro (EUR)
  # UK Pound Sterling (GBP)
  # Australian Dollar (AUD)
  # New Zealand Dollar (NZD)
  # Unites States Dollar (USD)
  # Canadian Dollar (CAD)
  # Swiss Franc (CHF)
  # Japanese Yen (JPY)
  defp currency_data do
    [
      ["European Euro", "EUR", "€"],
      ["United Kingdom Pound Sterling", "GBP", "£"],
      ["Australian Dollar", "AUD", "$"],
      ["New Zealand Dollar", "NZD", "$"],
      ["United States Dollar", "USD", "$"],
      ["Canadian Dollar", "CAD", "$"],
      ["Swiss Franc", "CHF", "¥"],
      ["Japanese Yen", "JPY", "CHF"]
    ]
  end
end

defmodule FakeData.Work do
  import FakeData

  @doc """
  Generate job titles.

  Default is one title, however more can be specified.
  """
  def job_titles(list_length \\ 1) do
    titles() |> Enum.take_random(list_length)
  end

  defp titles() do
    read_vector("priv/data/job_titles.txt")
  end
end

defmodule FakeData.Names do
  import FakeData

  @doc """
  Generate full names for people, in format "fname surname".

  Default is one name, however more can be specified.
  """
  def full_names(list_length \\ 1) do
    for fname <- first_names(), lname <- last_names() do
      "#{fname} #{lname}"
    end |> Enum.take_random(list_length)
  end

  defp first_names() do
    read_vector("priv/data/first_names.txt")
  end

  defp last_names() do
    read_vector("priv/data/last_names.txt")
  end
end
