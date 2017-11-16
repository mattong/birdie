defmodule Birdie.ChirpTest do
  use Birdie.DataCase

  alias Birdie.Chirp

  describe "posts" do
    alias Birdie.Chirp.Post

    @valid_attrs %{content: "some content", timestamp: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{content: "some updated content", timestamp: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{content: nil, timestamp: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chirp.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Chirp.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Chirp.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Chirp.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.timestamp == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chirp.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Chirp.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.content == "some updated content"
      assert post.timestamp == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Chirp.update_post(post, @invalid_attrs)
      assert post == Chirp.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Chirp.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Chirp.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Chirp.change_post(post)
    end
  end
end
