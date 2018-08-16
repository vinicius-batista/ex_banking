defmodule ExBanking.UserAccount.Supervisor do
  @moduledoc """
  Dynamic supervisor for UserAccount server
  """

  use DynamicSupervisor
  alias ExBanking.UserAccount.Server

  @me __MODULE__

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_server(user) do
    DynamicSupervisor.start_child(@me, {Server, user})
  end
end
