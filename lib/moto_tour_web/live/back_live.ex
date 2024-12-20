defmodule MotoTourWeb.BackLive do
  use Phoenix.LiveView
  alias MotoTourWeb.Router.Helpers, as: Routes
  alias MotoTour.Circuits
  alias MotoTour.Reservations
  import Phoenix.HTML

  def mount(_params, _session, socket) do
    res = Reservations._res()
    cir = Circuits.list_circuits()
    {:ok, assign(socket, res: res, circuit: cir)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="row">

        <main role="main" class="col-md-11 ml-sm-auto col-lg-12 pt-3 px-4"><div class="chartjs-size-monitor" style="position: absolute; inset: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
            <h1 class="h2">Dashboard</h1>
            <!-- <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary">Share</button>
                <button class="btn btn-sm btn-outline-secondary">Export</button>
              </div>
              <button class="btn btn-sm btn-outline-secondary dropdown-toggle">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                This week
              </button>
            </div> -->
          </div>


          <h2>Réservation</h2>
          <div class="table-responsive">
            <table class="table table-striped table-sm" style="border: 1px solid">
              <thead>
                <tr>
                  <th>nom du circuit</th>
                  <th>nom</th>
                  <th>email</th>
                  <th>telephone</th>
                  <th>participant</th>
                  <th>date de reservation</th>
                  <th>besoin</th>
                  <th>date de creation</th>
                </tr>
              </thead>
              <tbody>
              <%= for resr <- @res do %>
                <tr>
                  <td><%= resr.circuit_nom %></td>
                  <td><%= resr.nom %></td>
                  <td><%= resr.email %></td>
                  <td><%= resr.telephone %></td>
                  <td><%= resr.participant %></td>
                  <td><%= resr.date_res %></td>
                  <td><%= resr.besoin %></td>
                  <td><%= resr.inserted_at %></td>
                  <td></td>
                </tr>
              <%= end %>
              </tbody>
            </table>
          </div>

          <h2>Circuit</h2>

          <div class="table-responsive">
            <table class="table table-striped table-sm" style="border: 1px solid">
              <thead>
                <tr>
                  <th>nom du circuit</th>
                  <th>tarifs</th>
                  <th>participant</th>
                  <th>moto</th>
                  <th>difficulté</th>
                </tr>
              </thead>
              <tbody>
              <%= for c <- @circuit do %>
                <tr>
                  <td><a href="" data-bs-toggle="modal" data-bs-target={"#exampleModal#{c.id}"}><%= c.nom %></a></td>
                  <td><%= c.tarifs %> €</td>
                  <td><%= if c.participant == nil, do: "illimité", else: c.participant %></td>
                  <td><%= c.moto %></td>
                  <td><%= c.difficulté %></td>
                  <td></td>
                </tr>

                  <!-- Modal -->
                  <div class="modal fade" id={"exampleModal#{c.id}"} tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content" style="width:800px">
                        <div class="modal-header">
                          <h5 class="modal-title" id="exampleModalLabel"><%= c.nom %></h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <h6>remarque sur le circuit</h6>
                        <div class="modal-body">
                          "<%= c.remarque%>"
                        </div>
                        <h6>prestation</h6>
                        <div class="modal-body">
                          <%= raw(c.details) %>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                        </div>
                      </div>
                    </div>
                  </div>

              <%= end %>
              </tbody>
            </table>
          </div>
        </main>
      </div>
    </div>


    """
  end

end
