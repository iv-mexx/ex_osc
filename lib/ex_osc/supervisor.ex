defmodule ExOsc.Supervisor do
  use Supervisor

  @moduledoc """
  Supervisor for MessageBuffer, Listener and Sender
  """

  def start_link(args \\ []) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(ExOsc.MessageBuffer, args),
      worker(ExOsc.Listener, args),
      worker(ExOsc.Sender, args)
    ]

    supervise(children, strategy: :one_for_one)
  end
end
