defmodule Vision.Repo do
  use Ecto.Repo,
    otp_app: :vision,
    adapter: Ecto.Adapters.Postgres
end
