defmodule ExBankingTest do
  @moduledoc """
  Tests for ExBanking
  """
  use ExUnit.Case
  doctest ExBanking

  @wrong_argument_error {:error, :wrong_arguments}

  test "create user name that is not a string should return error" do
    assert ExBanking.create_user(123) == @wrong_argument_error
  end

  test "pass wrong arguments to deposit should return error" do
    assert ExBanking.deposit(123, 123, 123) == @wrong_argument_error
  end

  test "pass wrong arguments to withdraw should return error" do
    assert ExBanking.withdraw(123, 123, 123) == @wrong_argument_error
  end
end
