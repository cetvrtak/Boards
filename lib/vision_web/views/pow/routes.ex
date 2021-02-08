defmodule VisionWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias VisionWeb.Router.Helpers, as: Routes

  @impl true
  def after_sign_in_path(conn), do: Routes.board_index_path(conn, :index)
end