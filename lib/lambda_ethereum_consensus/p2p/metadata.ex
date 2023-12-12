defmodule LambdaEthereumConsensus.P2P.Metadata do
  @moduledoc """
  This module handles Metadata's genserver to fetch and edit.
  """

  use GenServer

  alias SszTypes.Metadata

  @default_timeout 10_000

  ##########################
  ### Public API
  ##########################

  @spec get_seq_number() :: SszTypes.uint64()
  def get_seq_number do
    [seq_number] = get_metadata_attrs([:seq_number])
    seq_number
  end

  @spec get_metadata() :: Metadata.t()
  def get_metadata do
    GenServer.call(__MODULE__, :get_metadata, @default_timeout)
  end

  ##########################
  ### GenServer Callbacks
  ##########################

  @impl GenServer
  def init(metadata) do
    {:ok, metadata}
  end

  @impl GenServer
  def handle_call({:get_metadata_attrs, attrs}, _from, metadata) do
    values = Enum.map(attrs, &Map.fetch!(metadata, &1))
    {:reply, values, metadata}
  end

  @impl GenServer
  def handle_call(:get_metadata, _from, metadata) do
    {:reply, metadata}
  end

  ##########################
  ### Private Functions
  ##########################

  @spec get_metadata_attrs([atom()]) :: [any()]
  defp get_metadata_attrs(attrs) do
    GenServer.call(__MODULE__, {:get_metadata_attrs, attrs}, @default_timeout)
  end
end