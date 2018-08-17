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
    pid
    |> Process.info(:message_queue_len)
    |> has_more_than_10_requests()
  end

  defp has_more_than_10_requests({_, len}) when len > 10, do: {:error, :too_many_requests_to_user}
  defp has_more_than_10_requests({_, len}), do: {:ok, len}

  def format_money(money) do
    money
    |> Float.round(2)
  end

  def format_response({:ok, amount}) do
    formated_amount = format_money(amount)
    {:ok, formated_amount}
  end

  def format_response(error_message), do: {:error, error_message}

  def format_messages({:error, :user_does_not_exist}, :sender) do
    {:error, :sender_does_not_exist}
  end

  def format_messages({:error, :too_many_requests_to_user}, :sender) do
    {:error, :too_many_requests_to_sender}
  end

  def format_messages({:error, :user_does_not_exist}, :receiver) do
    {:error, :receiver_does_not_exist}
  end

  def format_messages({:error, :too_many_requests_to_user}, :receiver) do
    {:error, :too_many_requests_to_receiver}
  end

  def format_messages(pid, _), do: pid
end
