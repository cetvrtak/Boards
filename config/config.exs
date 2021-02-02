# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vision,
  ecto_repos: [Vision.Repo]

# Configures the endpoint
config :vision, VisionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g7Qd3h3hD3nXz0oojl8sYrJMPfhcMKfitIXqe2LMVv2peraq5BiNLr+a/Vy5xe3p",
  render_errors: [view: VisionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Vision.PubSub,
  live_view: [signing_salt: "T2DWVMtT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :vision, :pow,
  user: Vision.Users.User,
  repo: Vision.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
