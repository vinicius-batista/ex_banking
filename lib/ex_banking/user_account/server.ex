defmodule ExBanking.UserAccount.Server do
  @moduledoc """
  Module for server related to UserAccount
  """
  use GenServer

  alias ExBanking.UserAccount.Impl

  def start_link(user) do
    GenServer.start_link(__MODULE__, %{}, name: {:global, user})
  end

  def init(users_balance) do
    {:ok, users_balance}
  end

  def handle_call({:deposit, amount, currency}, _from, users_balance) do
    with new_users_balance <- Impl.deposit(amount, currency, users_balance),
         new_currency_amount <- Map.get(new_users_balance, currency) do
      {:reply, {:ok, new_currency_amount}, new_users_balance}
    end
  end

  def handle_call({:withdraw, amount, currency}, _from, users_balance) do
    with new_users_balance when is_map(new_users_balance) <-
           Impl.withdraw(amount, currency, users_balance),
         new_currency_amount <- Map.get(new_users_balance, currency) do
      {:reply, {:ok, new_currency_amount}, new_users_balance}
    else
      error -> {:reply, error, users_balance}
    end
  end
end
