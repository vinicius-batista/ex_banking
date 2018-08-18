defmodule ExBanking.HelpersTest do
  @moduledoc """
  Tests for Helpers
  """
  use ExUnit.Case
  alias ExBanking.{Helpers, UserAccount}

  setup_all do
    UserAccount.create_user("vinicius_123")
  end

  test "get_user_pid should return a valid pid" do
    assert is_pid(Helpers.get_user_pid("vinicius_123"))
  end

  test "check_too_many_requests return error if an user has more than 10 requests" do
    pid = Helpers.get_user_pid("vinicius_123")
    {status, _} = Helpers.check_too_many_requests(pid)
    assert status == :ok

    tasks =
      1..300
      |> Enum.map(fn _ ->
        Task.async(fn -> UserAccount.deposit("vinicius_123", 100.00, "dollar") end)
      end)
      |> Enum.map(&Task.await/1)

    assert Enum.member?(tasks, {:error, :too_many_requests_to_user}) == true
  end

  test "format money should return a number with two decimals" do
    assert Helpers.format_money(10.00) == 10.00
  end
end
