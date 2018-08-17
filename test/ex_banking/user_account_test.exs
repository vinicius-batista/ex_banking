defmodule ExBanking.UserAccountTest do
  @moduledoc """
  Tests for UserAccount
  """
  use ExUnit.Case
  alias ExBanking.UserAccount
  doctest UserAccount

  setup_all do
    UserAccount.create_user("ronaldo")
  end

  test "create user that already existis should return an error" do
    assert UserAccount.create_user("ronaldo") == {:error, :user_already_exists}
  end

  test "create user should return ok" do
    assert UserAccount.create_user("vinicius") == :ok
  end

  test "Deposit an amount to an exists user" do
    assert UserAccount.deposit("ronaldo", 10.00, "dolar") == {:ok, 10.00}
  end

  test "Deposit an amount to a not exists user" do
    assert UserAccount.deposit("random_guy", 10.00, "dolar") == {:error, :user_does_not_exist}
  end

  test "Withdraw an amount to an exists user" do
    UserAccount.deposit("ronaldo", 10.00, "dolar")
    {:ok, amount} = UserAccount.withdraw("ronaldo", 10.00, "dolar")
    assert amount >= 0.00
  end

  test "Withdraw an amount to a not exists user" do
    assert UserAccount.withdraw("random_guy", 10.00, "dolar") == {:error, :user_does_not_exist}
  end

  test "Withdraw an amount that not exists should return an error" do
    assert UserAccount.withdraw("ronaldo", 150.00, "dolar") == {:error, :not_enough_money}
  end
end
