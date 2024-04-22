defmodule Exercise.Services.CurrencyConverterTest do
  @moduledoc false

  use ExUnit.Case
  alias Exercise.Services.CurrencyConverter, as: Converter

  describe "convert/3" do
    test "converting from a less valuable to a more valuable currency results in a smaller amount" do
      Enum.each([100, 200, 300], fn amount ->
        {:ok, result} = Converter.convert("JPY", "GBP", amount)
        assert result < amount
      end)
    end

    test "when one of the currencies is unsupported we get an error tuple as a result" do
      for {from, to, message} <- [
        {"XYZ", "GBP", "unsupported currencies conversion"},
        {"AAA", "ZZZ", "unsupported currencies conversion"}
      ] do
        assert {:error, ^message} = Converter.convert(from, to, 100)
      end
    end

    test "when a non-numeric amount is converted we get an error result" do
      Enum.each([nil, "one hundred", :one_hundred], fn amount ->
        assert {:error, "invalid argument `amount`. Must be a numeric value."} = Converter.convert("JPY", "GBP", amount)
      end)
    end
  end
end
