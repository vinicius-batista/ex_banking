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
end
