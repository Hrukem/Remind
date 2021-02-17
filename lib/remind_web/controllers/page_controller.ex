defmodule RemindWeb.PageController do
  use RemindWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
