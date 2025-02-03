defmodule MotoTourWeb.PageController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits
  alias MotoTour.Reservations
  alias MotoTour.Image

  def robots(conn, _params) do
    text(conn, """
    User-agent: *
    Disallow: /admin/
    Allow: /
    """)
  end

  def sitemap(conn, _params) do
    conn
    |> put_resp_content_type("application/xml")
    |> send_file(200, "priv/static/sitemap.xml")
  end

  def index(conn, _params) do
    # circuits = Circuits.list_circuits()
    circuits = Image.get_principal_photos()

    conn
      |> assign(:meta_description, "Découvrez Madagascar à moto à travers des circuits d’enduro sport palpitants, entre paysages sauvages et étendues désertiques.")
      |> assign(:page_title, "Moto Madagascar")
      |> render("index.html", circuits: circuits)
  end

  # defp build_event_schema(circuit) do
  #   %{
  #     "@context" => "https://schema.org",
  #     "@type" => "Event",
  #     "name" => circuit.circuit_nom,
  #     "location" => %{
  #       "@type" => "Place",
  #       "name" => circuit.circuit_nom,
  #     },
  #     "image" => circuit.photo,
  #     "description" => circuit.desc_card,
  #     "offers" => %{
  #       "@type" => "Offer",
  #       "url" => circuit.idcircuit,
  #       "price" => circuit.tarifs,
  #       "priceCurrency" => "EUR",
  #       "availability" => "https://schema.org/InStock"
  #     }
  #   }
  # end


  def menu(conn, _params) do
    res = Reservations._res()
    cir = Circuits.list_circuits()
    render(conn, "dashboard.html", res: res, circuit: cir)
  end

  def propos(conn, _params) do
    conn
      |> assign(:meta_description, "Notre équipe franco-malgache, composée de guides moto, mécaniciens spécialisés, vous fera partager leur passion pour ce pays madagascar . By François Serrano")
      |> assign(:page_title, "Qui sommes-nous ? L’équipe de Moto Tour Madagascar")
      |> render("propos.html")
  end


  def liste(conn, _params) do
    circuits = Circuits.list_circuits()
    # Passer les produits au template
    render(conn, "liste.html", circuits: circuits)
  end

  def bcircuit(conn, _params) do
    cir = Circuits.list_circuits_back()
    render(conn, "backcircuit.html", circuit: cir)
  end
end
