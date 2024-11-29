defmodule MotoTourWeb.ReservationController do
  use MotoTourWeb, :controller
  alias MotoTour.Repo
  alias MotoTour.Reservations

  def index(conn, _params) do
    res = Reservations._res()
    render(conn, "index.html", res: res)
  end

end
