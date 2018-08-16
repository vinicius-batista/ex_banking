defmodule ExBanking.UserAccount do
  @moduledoc """
  Module for all public API related to UserAccount
  """
  alias ExBanking.UserAccount.Supervisor

  def create_user(user) do
    case Supervisor.add_server(user) do
      {:ok, _pid} -> :ok
      {:error, {:already_started, _pid}} -> {:error, :user_already_exists}
    end
  end
end
