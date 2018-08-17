defmodule ExBanking.UserAccount.ImplTest do
  @moduledoc """
  Tests for UserAccount Impl
  """
  use ExUnit.Case
  alias ExBanking.UserAccount.Impl

  test "deposit in empty currency should return given amount" do
    assert Impl.deposit(20.00, "dolar", %{}) == %{"dolar" => 20.00}
  end

  test "deposit in not empty currency should sum balance with given amount" do
    assert Impl.deposit(20.00, "dolar", %{"dolar" => 50.00}) == %{"dolar" => 70.00}
  end

  test "withdraw with enough money should subtract balance with given amount" do
    assert Impl.withdraw(10.00, "dolar", %{"dolar" => 50.00}) == %{"dolar" => 40.00}
  end

  test "withdraw with not enough money should return an error" do
    assert Impl.withdraw(10.00, "dolar", %{"dolar" => 5.00}) == :not_enough_money
  end
end
