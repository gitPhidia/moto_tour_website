defmodule MotoTourWeb.PageController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits
  alias MotoTour.Reservations
  alias MotoTour.Image

  def index(conn, _params) do
    # circuits = Circuits.list_circuits()
    circuits = Image.get_principal_photos()
    render(conn, "index.html", circuits: circuits)
  end

  def menu(conn, _params) do
    res = Reservations._res()
    cir = Circuits.list_circuits()
    render(conn, "dashboard.html", res: res, circuit: cir)
  end

  def propos(conn, _params) do
    render(conn, "propos.html")
  end

  # def contact(conn, _params) do
  #   render(conn, "contact.html")
  # end

  def liste(conn, _params) do
    circuits = Circuits.list_circuits()
    # Passer les produits au template
    render(conn, "liste.html", circuits: circuits)
  end

  def bcircuit(conn, _params) do
    cir = Circuits.list_circuits_back()
    render(conn, "backcircuit.html", circuit: cir)
  end

  # def ajoutc(conn, _params) do
  #   changeset = Circuits.change_circuit(%Circuit{})
  #   render(conn, "ajoutcircuit.html", changeset: changeset)
  # end
end
