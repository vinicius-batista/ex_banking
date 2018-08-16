defmodule ExBanking.Helpers do
  @moduledoc """
  Module for Helpers functions
  """
  def get_user_pid(user) do
    GenServer.whereis({:global, user})
  end

  def user_exists?(nil), do: {:error, :user_does_not_exist}

  def user_exists?(_), do: true

  def check_too_many_requests(pid) do
    {_, len} = Process.info(pid, :message_queue_len)
    has_more_than_10_requests(len)
  end

  defp has_more_than_10_requests(len) when len > 10, do: {:error, :too_many_requests_to_user}
  defp has_more_than_10_requests(len), do: {:ok, len}

  def format_money(money) do
    money
    |> Float.round(2)
  end
end
