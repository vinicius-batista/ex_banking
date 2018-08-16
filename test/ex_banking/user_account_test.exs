defmodule ExBanking.UserAccountTest do
  @moduledoc """
  Tests for UserAccount
  """
  use ExUnit.Case
  alias ExBanking.UserAccount
  doctest UserAccount

  test "create user should return ok" do
    assert UserAccount.create_user("vinicius") == :ok
  end

  test "create user that already existis should return an error" do
    assert UserAccount.create_user("vinicius") == {:error, :user_already_exists}
  end
end
