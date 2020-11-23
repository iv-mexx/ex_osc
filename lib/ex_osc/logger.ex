defmodule ExOsc.Logger do
  use GenStage
  @moduledoc """
  Simple Logger process that listens for incoming events and inspects them.
  """

  require Logger
  alias ExOsc.MessageBuffer

  def start_logger do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:consumer, :ok, subscribe_to: [MessageBuffer]}
  end

  # def stop_logger(pid) do
  #   GenStage.cancel(pid, :shutdown)
  # end

  def handle_events(events, _from, state) do
    for event <- events do
      Logger.info("OSC: #{inspect(event)}")
    end
    {:noreply, [], state}
  end
end
