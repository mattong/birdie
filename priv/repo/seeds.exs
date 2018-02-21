# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Birdie.Repo.insert!(%Birdie.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BirdieWeb.InsertController

InsertController.create_a_lot_of_users(1_000_000)

InsertController.insert_multiple_times(1_000_000)
