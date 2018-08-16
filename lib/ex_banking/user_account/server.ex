defmodule ExBanking.UserAccount.Server do
  @moduledoc """
  Module for server related to UserAccount
  """
  use GenServer

  def start_link(user) do
    GenServer.start_link(__MODULE__, %{}, name: {:global, user})
  end

  def init(state) do
    {:ok, state}
  end
end
