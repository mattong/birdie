# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :birdie,
  ecto_repos: [Birdie.Repo]

# Configures the endpoint
config :birdie, BirdieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M2MG/NLGu9uI8NrX+DLu5Pj0v9O62va9/URDPieRReH7Ef5M38tbwv636sgswRMA",
  render_errors: [view: BirdieWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Birdie.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
