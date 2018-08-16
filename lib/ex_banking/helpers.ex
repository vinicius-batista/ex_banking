defmodule ExBanking.Helpers do
  @moduledoc """
  Module for Helpers functions
  """
  def get_user_pid(user) do
    GenServer.whereis({:global, user})
  end

  def check_user_exists(nil), do: {:error, :user_does_not_exist}

  def check_user_exists(_), do: true
end
