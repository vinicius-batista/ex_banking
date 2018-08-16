defmodule ExBanking.UserAccount.Impl do
  @moduledoc """
  Module for all logic bussines related to UserAccount
  """

  def deposit(amount, currency, users_balance) do
    Map.update(users_balance, currency, amount, fn
      currency_amount -> currency_amount + amount
    end)
  end
end
