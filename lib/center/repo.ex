defmodule Center.Repo do
  use Ecto.Repo,
    otp_app: :center,
    adapter: Ecto.Adapters.Postgres
end
