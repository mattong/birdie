defmodule InsertMulti do
  alias Birdie.Chirps.Chirper

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
