defmodule ExBanking.UserAccount do
  @moduledoc """
  Module for all public API related to UserAccount
  """
  alias ExBanking.UserAccount.{Supervisor}
  alias ExBanking.Helpers

  def create_user(user) do
    case Supervisor.add_server(user) do
      {:ok, _pid} -> :ok
      {:error, {:already_started, _pid}} -> {:error, :user_already_exists}
    end
  end

  def deposit(user, amount, currency) do
    check_and_call_server(user, &GenServer.call(&1, {:deposit, amount, currency}))
  end

  def withdraw(user, amount, currency) do
    check_and_call_server(user, &GenServer.call(&1, {:withdraw, amount, currency}))
  end

  def get_balance(user, currency) do
    check_and_call_server(user, &GenServer.call(&1, {:get_balance, currency}))
  end

  def send(from_user, to_user, amount, currency) do
    with sender_pid when is_pid(sender_pid) <- all_checks_sender(from_user),
         receiver_pid when is_pid(receiver_pid) <- all_checks_receiver(to_user),
         {:ok, from_user_amount} <- GenServer.call(sender_pid, {:withdraw, amount, currency}),
         {:ok, to_user_amount} <- GenServer.call(receiver_pid, {:deposit, amount, currency}) do
      {:ok, from_user_amount, to_user_amount}
    end
  end

  defp check_and_call_server(user, fun) do
    with pid when is_pid(pid) <- all_checks(user) do
      fun.(pid)
      |> Helpers.format_response()
    end
  end

  defp all_checks(user) do
    with pid <- Helpers.get_user_pid(user),
         true <- Helpers.user_exists?(pid),
         {:ok, _} <- Helpers.check_too_many_requests(pid) do
      pid
    end
  end

  defp all_checks_sender(user) do
    user
    |> all_checks()
    |> Helpers.format_messages(:sender)
  end

  defp all_checks_receiver(user) do
    user
    |> all_checks()
    |> Helpers.format_messages(:receiver)
  end
end
