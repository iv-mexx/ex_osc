defmodule ExOsc.Application do
  use Application

  @moduledoc """
  Supervisor for MessageBuffer, Listener and Sender
  """

  def start(_type, args) do
    children = [
      # Define workers and child supervisors to be supervised
      {ExOsc.MessageBuffer, args},
      {ExOsc.Listener, args},
      {ExOsc.Sender, args}
    ]

    opts = [strategy: :one_for_one, name: ExOsc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
