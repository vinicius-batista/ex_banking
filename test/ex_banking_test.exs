defmodule ExBankingTest do
  @moduledoc """
  Tests for ExBanking
  """
  use ExUnit.Case
  use ExUnitProperties
  doctest ExBanking

  @wrong_argument_error {:error, :wrong_arguments}

  property "create user name should work only with strings" do
    check all correct_name <- string(:alphanumeric) |> uniq_list_of(min_length: 1),
              incorrect_name <- integer() do
      assert ExBanking.create_user(correct_name |> List.to_string()) == :ok
      assert ExBanking.create_user(incorrect_name) == @wrong_argument_error
    end
  end

  property "deposit should verify correct type of arguments" do
    check all number <- positive_integer() do
      assert ExBanking.deposit(number, number, number) == @wrong_argument_error
    end
  end

  property "withdraw should verify correct type of arguments" do
    check all number <- integer() do
      assert ExBanking.withdraw(number, number, number) == @wrong_argument_error
    end
  end

  property "get_balance should verify correct type of arguments" do
    check all number <- integer() do
      assert ExBanking.get_balance(number, number) == @wrong_argument_error
    end
  end
end
