defmodule BirdieWeb.InsertController do
  alias Birdie.Chirps.Chirper
  alias Birdie.Accounts

  def create_a_lot_of_users(n) do
    do_create_a_user(n)
  end

  def do_create_a_user(n) when n == 0 do
    email = "lele#{n}@email.com"
    case Accounts.create_user(%{"email" => email, "password" => "password"}) do
      {:ok, user} ->
        IO.inspect(user)
      {:error, error} ->
        IO.inspect(error)
    end
  end

  def do_create_a_user(n) do
    email = "lele#{n}@email.com"
    case Accounts.create_user(%{"email" => email, "password" => "password"}) do
      {:ok, user} ->
        IO.inspect(user)
        do_create_a_user(n-1)
      {:error, error} ->
        IO.inspect(error)
    end
  end

  def insert_multiple_times(n) do
    do_insert_multiple_times(n)
  end

  defp do_insert_multiple_times(n) when n == 0 do
    Chirper.follow_user(%{follower: n, following: 1})
  end

  defp do_insert_multiple_times(n) do
    Chirper.follow_user(%{follower: n, following: 1})
    insert_multiple_times(n-1)
  end
end
