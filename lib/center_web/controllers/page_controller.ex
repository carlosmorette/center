defmodule CenterWeb.PageController do
  use CenterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
