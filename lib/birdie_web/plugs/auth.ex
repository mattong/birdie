defmodule Birdie.Plug.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]
  alias Birdie.User

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    assign_current_user(conn, user_id, repo)
  end

  # When current user is empty(?) does nothing
  def assign_current_user(
      %Plug.Conn{assigns: %{current_user: %User{}}} = conn,
      _user_id,  _repo) do
    conn
  end

  def assign_current_user(conn, user_id, repo) do
    assign(conn, :current_user, user_id && repo.get(User, user_id))
    # Assigns user_id to :current_user in :assigns when user_id exists in database
  end

  def sign_in(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true) # renews session cookie (find out what this means)
  end

  def sign_out(conn), do: configure_session(conn, drop: true) # drops the cookie

  def user_auth(conn, email, password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(User, email: email)
    do_password_auth(conn, user, password)
  end

  # If user isn't found, run this to fool them h4chkzors
  defp do_password_auth(conn, nil, _password) do
    dummy_checkpw()
    {:error, :not_found, conn}
  end

  # Use checkpw from Comeonin to check password match
  defp do_password_auth(conn, user, password) do
    if checkpw(password, user.hashed_password) do
      {:ok, sign_in(conn, user)}
    else
      {:error, :unauthorized, conn}
    end
  end

  def authenticate(%Plug.Conn{assigns: %{current_user: nil}} = conn, _opts) do
    conn
    |> put_flash(:error, "You must be signed in to do that")
    |> redirect(to: Birdie.Router.Helpers.registration_path(conn, :new))
  end
  def authenticate(conn, _opts), do: conn
end 
