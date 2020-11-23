defmodule ExOsc.MessageBuffer do
  use GenStage

  @moduledoc """
  GenStage to buffer receifed OSC messages for consumer
  """

  @default_buffer_size 10

  @doc """
  Starts the Buffer.
  """
  def start_link(options \\ []) do
    buffer_size = Keyword.get(options, :buffer_size, @default_buffer_size)
    GenStage.start_link(__MODULE__, buffer_size, name: __MODULE__)
  end

  @doc """
  Sends an event and returns only after the event is dispatched.
  """
  def sync_notify(event, timeout \\ 5000) do
    GenStage.call(__MODULE__, {:notify, event}, timeout)
  end

  ## Callbacks

  def init(buffer_size) do
    {:producer, :ok, dispatcher: GenStage.BroadcastDispatcher, buffer_size: buffer_size}
  end

  def handle_call({:notify, event}, _from, state) do
    {:reply, :ok, [event], state}
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end
end
