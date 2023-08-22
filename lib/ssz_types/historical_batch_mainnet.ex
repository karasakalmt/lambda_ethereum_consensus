defmodule SszTypes.HistoricalBatchMainnet do
  @moduledoc """
  Struct definition for `HistoricalBatchMainnet`.
  Related definitions in `native/ssz_nif/src/types/`.
  """

  fields = [
    :block_roots,
    :state_roots
  ]

  @enforce_keys fields
  defstruct fields

  @type t :: %__MODULE__{
          # max size is 8192
          block_roots: list(SszTypes.root()),
          state_roots: list(SszTypes.root())
        }
end
