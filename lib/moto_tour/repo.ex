defmodule MotoTour.Repo do
  use Ecto.Repo,
    otp_app: :moto_tour,
    adapter: Ecto.Adapters.Postgres
end
