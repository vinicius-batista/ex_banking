defmodule ExBanking do
  @moduledoc """
  Documentation for ExBanking.
  """
  alias ExBanking.UserAccount

  @type banking_error ::
          {:error,
           :wrong_arguments
           | :user_already_exists
           | :user_does_not_exist
           | :not_enough_money
           | :sender_does_not_exist
           | :receiver_does_not_exist
           | :too_many_requests_to_user
           | :too_many_requests_to_sender
           | :too_many_requests_to_receiver}

  @spec create_user(user :: String.t()) :: :ok | banking_error
  def create_user(user) when is_binary(user) do
    UserAccount.create_user(user)
  end

  def create_user(_) do
    {:error, :wrong_arguments}
  end

  @spec deposit(user :: String.t(), amount :: number, currency :: String.t()) ::
          {:ok, new_balance :: number} | banking_error
  def deposit(user, amount, currency)
      when is_binary(user) and is_number(amount) and amount > 0 and is_binary(currency) do
    UserAccount.deposit(user, amount, currency)
  end

  def deposit(_, _, _) do
    {:error, :wrong_arguments}
  end

  @spec withdraw(user :: String.t(), amount :: number, currency :: String.t()) ::
          {:ok, new_balance :: number} | banking_error
  def withdraw(_user, _amount, _currency) do
    {:ok, 0}
  end

  @spec get_balance(user :: String.t(), currency :: String.t()) ::
          {:ok, balance :: number} | banking_error
  def get_balance(_user, _currency) do
    {:ok, 0}
  end

  @spec send(
          from_user :: String.t(),
          to_user :: String.t(),
          amount :: number,
          currency :: String.t()
        ) :: {:ok, from_user_balance :: number, to_user_balance :: number} | banking_error
  def send(_from_user, _to_user, _amount, _currency) do
    {:ok, 0, 0}
  end
end
