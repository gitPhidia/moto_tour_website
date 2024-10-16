defmodule MotoTourWeb.PageController do
  use MotoTourWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
