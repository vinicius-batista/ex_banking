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
    with pid <- Helpers.get_user_pid(user),
         true <- Helpers.user_exists?(pid),
         {:ok, _} <- Helpers.check_too_many_requests(pid) do
      GenServer.call(pid, {:deposit, amount, currency})
      |> Helpers.format_response()
    end
  end

  def withdraw(user, amount, currency) do
    with pid <- Helpers.get_user_pid(user),
         true <- Helpers.user_exists?(pid),
         {:ok, _} <- Helpers.check_too_many_requests(pid) do
      GenServer.call(pid, {:withdraw, amount, currency})
      |> Helpers.format_response()
    end
  end
end
