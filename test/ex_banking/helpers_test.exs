defmodule ExBanking.HelpersTest do
  @moduledoc """
  Tests for Helpers
  """
  use ExUnit.Case
  alias ExBanking.{Helpers, UserAccount}

  test "get_user_pid should return a valid pid" do
    UserAccount.create_user("vinicius_123")
    assert is_pid(Helpers.get_user_pid("vinicius_123"))
  end
end
