defmodule ExBanking.UserAccountTest do
  @moduledoc """
  Tests for UserAccount
  """
  use ExUnit.Case
  alias ExBanking.UserAccount
  doctest UserAccount

  test "create user that already existis should return an error" do
    UserAccount.create_user("ronaldo")
    assert UserAccount.create_user("ronaldo") == {:error, :user_already_exists}
  end

  test "create user should return ok" do
    assert UserAccount.create_user("vinicius") == :ok
  end

  test "Deposit an amount to an exists user" do
    :ok = UserAccount.create_user("random_guy")
    assert UserAccount.deposit("random_guy", 10, "dolar") == {:ok, 10.00}
  end

  test "Deposit an amount to a not exists user" do
    assert UserAccount.deposit("random_guy123", 10, "dolar") == {:error, :user_does_not_exist}
  end
end
