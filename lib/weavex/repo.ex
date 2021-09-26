defmodule Weavex.Repo do
  use Ecto.Repo,
    otp_app: :weavex,
    adapter: Ecto.Adapters.Postgres
end
