defmodule ExBanking.UserAccount.ImplTest do
  @moduledoc """
  Tests for UserAccount Impl
  """
  use ExUnit.Case
  alias ExBanking.UserAccount.Impl

  test "deposit in empty currency should return given amount" do
    assert Impl.deposit(20, "dolar", %{}) == %{"dolar" => 20}
  end

  test "deposit in not empty currency should sum balance with given amount" do
    assert Impl.deposit(20, "dolar", %{"dolar" => 50}) == %{"dolar" => 70}
  end
end
