defmodule ExBanking.UserAccount.Impl do
  @moduledoc """
  Module for all logic bussines related to UserAccount
  """

  def deposit(amount, currency, users_balance) do
    Map.update(users_balance, currency, amount, fn
      currency_amount -> currency_amount + amount
    end)
  end

  def withdraw(amount, currency, users_balance) do
    currency_amount = Map.get(users_balance, currency, 0.00)

    case currency_amount - amount do
      result when result < 0 ->
        :not_enough_money

      result ->
        Map.update(users_balance, currency, amount, fn
          _ -> result
        end)
    end
  end
end
