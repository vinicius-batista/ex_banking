defmodule ExBanking.UserAccount.ImplTest do
  @moduledoc """
  Tests for UserAccount Impl
  """
  use ExUnit.Case
  use ExUnitProperties
  alias ExBanking.UserAccount.Impl

  describe "deposit" do
    property "deposit always add the value to the currency" do
      check all amount <- float(),
                currency <- string(:alphanumeric) do
        expected = Map.put(%{}, currency, amount)
        assert Impl.deposit(amount, currency, %{}) == expected
      end
    end

    property "deposit in not empty currency should sum balance with given amount" do
      check all amount <- float(),
                currency <- string(:alphanumeric) do
        fake_balance = Map.put(%{}, currency, amount)
        expected = Map.put(%{}, currency, amount * 2)
        assert Impl.deposit(amount, currency, fake_balance) == expected
      end
    end
  end

  describe "withdraw" do
    property "withdraw with not enough money should return an error" do
      check all amount <- positive_integer(),
                currency <- string(:alphanumeric) do
        assert Impl.withdraw(amount, currency, %{}) == :not_enough_money
      end
    end

    property "withdraw with enough money should subtract balance with given amount" do
      check all amount <- positive_integer(),
                currency <- string(:alphanumeric) do
        fake_balance = Map.put(%{}, currency, amount * 2)
        expected = Map.put(%{}, currency, amount)
        assert Impl.withdraw(amount, currency, fake_balance) == expected
      end
    end
  end
end
