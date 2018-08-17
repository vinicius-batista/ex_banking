defmodule ExBanking.UserAccountTest do
  @moduledoc """
  Tests for UserAccount
  """
  use ExUnit.Case
  alias ExBanking.UserAccount
  doctest UserAccount
  @valid_user "ronaldo"
  @invalid_user "random_guy"

  setup_all do
    UserAccount.create_user(@valid_user)
  end

  test "create user that already existis should return an error" do
    assert UserAccount.create_user(@valid_user) == {:error, :user_already_exists}
  end

  test "create user should return ok" do
    assert UserAccount.create_user("vinicius") == :ok
  end

  test "Deposit an amount to an exists user" do
    {:ok, amount} = UserAccount.deposit(@valid_user, 10.00, "dolar")
    assert amount >= 10.00
  end

  test "Deposit an amount to a not exists user" do
    assert UserAccount.deposit(@invalid_user, 10.00, "dolar") == {:error, :user_does_not_exist}
  end

  test "Withdraw an amount to an exists user" do
    UserAccount.deposit(@valid_user, 10.00, "dolar")
    {:ok, amount} = UserAccount.withdraw(@valid_user, 10.00, "dolar")
    assert amount >= 0.00
  end

  test "Withdraw an amount to a not exists user" do
    assert UserAccount.withdraw(@invalid_user, 10.00, "dolar") == {:error, :user_does_not_exist}
  end

  test "Withdraw an amount that not exists should return an error" do
    assert UserAccount.withdraw(@valid_user, 150.00, "dolar") == {:error, :not_enough_money}
  end

  test "Get balance from an user" do
    user = @valid_user
    UserAccount.deposit(user, 10.00, "dolar")
    {:ok, amount} = UserAccount.get_balance(user, "dolar")
    assert amount >= 10.00
  end
end
