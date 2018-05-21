defmodule PodBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    slack_token = System.get_env("SLACK_TOKEN")

    if slack_token == nil do
      raise "SLACK_TOKEN environment variable must be set."
    end

    # List all child processes to be supervised
    children = [
      supervisor(PodBot.Repo, []),
      supervisor(Slack.Bot, [PodBot, [], slack_token])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PodBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
