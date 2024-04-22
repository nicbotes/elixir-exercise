defmodule Exercise.Services.CurrencyConverter do
  @moduledoc """
  Module implementing the currency conversion service

  Note: The current implementation will not contact any external service
  and will use fixed conversion rates that will most likely not be the correct ones.
  """

  @doc """
  Converts an amount from one currency to another using a predefined exchange rate.

  ## Parameters
  - `from`: The currency code (as a string) you are converting from.
  - `to`: The currency code (as a string) you are converting to.
  - `amount`: The numeric amount to be converted.

  Returns {:ok, converted_amount} in case of success, {:error, reason} otherwise.

  Typical error reasons:
  - `unsupported currencies conversion` when the conversion fails due to an undefined conversion rate.
  - `id argument `amount`. Must be a numeric value.` when the amount is non-numeric.

  ## Examples

      iex> Exercise.Services.CurrencyConverter.convert("USD", "GBP", 100)
      {:ok, 73.0}

      iex> Exercise.Services.CurrencyConverter.convert("USD", "INR", 100)
      {:error, "unsupported currencies conversion"}
  """
  def convert(from, to, amount) when is_number(amount) do
    rate_conversion_key = "#{from}#{to}"

    case rates()[rate_conversion_key] do
      rate when is_number(rate) -> {:ok, amount * rate}
      nil -> {:error, "unsupported currencies conversion"}
    end
  end

  def convert(_, _, _amount) do
    {:error, "invalid argument `amount`. Must be a numeric value."}
  end

  defp rates do
    %{
      "EURGBP" => 0.851,
      "EURAUD" => 1.60097,
      "EURNZD" => 1.6786,
      "EURUSD" => 1.1839,
      "EURCAD" => 1.48286,
      "EURCHF" => 1.0739,
      "EURJPY" => 129.831,
      "GBPEUR" => 1.1738,
      "GBPAUD" => 1.888072,
      "GBPNZD" => 1.97225,
      "GBPUSD" => 1.39055,
      "GBPCAD" => 1.74178,
      "GBPCHF" => 1.26131,
      "GBPJPY" => 152.487,
      "AUDGBP" => 0.53143,
      "AUDEUR" => 0.62432,
      "AUDNZD" => 1.04855,
      "AUDUSD" => 0.73937,
      "AUDCAD" => 0.92607,
      "AUDCHF" => 0.67074,
      "AUDJPY" => 81.101,
      "NZDGBP" => 0.50687,
      "NZDAUD" => 0.9533,
      "NZDEUR" => 0.59542,
      "NZDUSD" => 0.7053,
      "NZDCAD" => 0.88325,
      "NZDCHF" => 0.63965,
      "NZDJPY" => 77.355,
      "USDGBP" => 0.71889,
      "USDAUD" => 1.35222,
      "USDNZD" => 1.4173,
      "USDEUR" => 0.8442,
      "USDCAD" => 1.25243,
      "USDCHF" => 0.90686,
      "USDJPY" => 109.67,
      "CADGBP" => 0.5735,
      "CADAUD" => 1.0794,
      "CADNZD" => 1.1311,
      "CADUSD" => 0.7982,
      "CADEUR" => 0.674,
      "CADCHF" => 0.7229,
      "CADJPY" => 87.572,
      "CHFGBP" => 0.7923,
      "CHFAUD" => 1.491,
      "CHFNZD" => 1.5623,
      "CHFUSD" => 1.1029,
      "CHFCAD" => 1.3803,
      "CHFEUR" => 0.9305,
      "CHFJPY" => 120.982,
      "JPYGBP" => 0.00655,
      "JPYAUD" => 0.01233,
      "JPYNZD" => 0.01293,
      "JPYUSD" => 0.00911950,
      "JPYCAD" => 0.01141600,
      "JPYCHF" => 0.00826400,
      "JPYEUR" => 0.00769860
    }
  end
end
