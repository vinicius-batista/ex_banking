defmodule ExBanking.UserAccountTest do
  @moduledoc """
  Tests for UserAccount
  """
  use ExUnit.Case
  alias ExBanking.UserAccount
  doctest UserAccount
  @valid_user "ronaldo"
  @valid_user_2 "ronaldo_2"
  @invalid_user "random_guy"

  setup_all do
    UserAccount.create_user(@valid_user)
    UserAccount.create_user(@valid_user_2)
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
    UserAccount.deposit(@valid_user, 10.00, "dolar")
    {:ok, amount} = UserAccount.get_balance(@valid_user, "dolar")
    assert amount >= 10.00
  end

  test "send should return errors with invalid users" do
    assert UserAccount.send(@valid_user, @invalid_user, 10.00, "dolar") ==
             {:error, :receiver_does_not_exist}

    assert UserAccount.send(@invalid_user, @valid_user, 10.00, "dolar") ==
             {:error, :sender_does_not_exist}
  end

  test "send should work correctly" do
    UserAccount.deposit(@valid_user, 13.00, "dolar")

    {:ok, from_user_amount, to_user_amount} =
      UserAccount.send(@valid_user, @valid_user_2, 13.00, "dolar")

    assert to_user_amount == 13.00
    assert from_user_amount != 13.00
  end
end
