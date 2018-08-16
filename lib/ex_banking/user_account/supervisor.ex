defmodule ExBanking.UserAccount.Supervisor do
  @moduledoc """
  Dynamic supervisor for UserAccount server
  """

  use DynamicSupervisor

  @me __MODULE__

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
