defmodule ExBanking.UserAccount.Server do
  @moduledoc """
  Module for server related to UserAccount
  """
  use GenServer

  def init(user_name) do
    {:ok, {user_name, 0}}
  end
end
