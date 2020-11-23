defmodule ExOsc do
  use Application

  @moduledoc """
  ExOsc
  """

  def start(_type, args) do
    ExOsc.Supervisor.start_link(args)
  end
end
