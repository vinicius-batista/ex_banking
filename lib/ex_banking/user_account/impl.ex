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
    currency_amount = get_amount(users_balance, currency)

    case currency_amount - amount do
      result when result < 0 ->
        :not_enough_money

      result ->
        Map.update(users_balance, currency, amount, fn
          _ -> result
        end)
    end
  end

  def get_amount(users_balance, currency) do
    Map.get(users_balance, currency, 0.00)
  end
end
