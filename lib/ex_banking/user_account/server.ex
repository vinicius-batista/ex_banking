defmodule ExBanking.UserAccount.Server do
  @moduledoc """
  Module for server related to UserAccount
  """
  use GenServer

  alias ExBanking.UserAccount.Impl
  alias ExBanking.Helpers

  def start_link(user) do
    GenServer.start_link(__MODULE__, %{}, name: {:global, user})
  end

  def init(users_balance) do
    {:ok, users_balance}
  end

  def handle_call({:deposit, amount, currency}, _from, users_balance) do
    with new_users_balance <- Impl.deposit(amount, currency, users_balance),
         new_currency_amount <- Map.get(new_users_balance, currency),
         formated_amount <- Helpers.format_money(new_currency_amount) do
      {:reply, {:ok, formated_amount}, new_users_balance}
    end
  end
end
