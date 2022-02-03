defmodule MerkleRoot do
  @moduledoc """
  `MerkleRoot` is a micro library for getting Merkle root from the hex-encoded transactions.
  """

  @doc """
  Gets the Merkle root for the transactions as input.
  Iput can be file path or list

  ## Examples

      iex> MerkleRoot.get_root(["4cb784cc0fcfcbe2e9f7602ed4a6d0ac853271a2a38c6480c6d6e565fce7487d"], :list)
      "4cb784cc0fcfcbe2e9f7602ed4a6d0ac853271a2a38c6480c6d6e565fce7487d"

  """
  def get_root(transactions, :list) do
    if (is_list(transactions)) do
      if (length(transactions) > 1 ) do
        transactions
        |> Enum.chunk_every(2)
        |> Enum.map(fn pair -> pair |> Enum.map(fn elem -> elem |> String.replace("\n", "") end) end)
        |> Enum.map(&hash_branch/1)
        |> get_root(:list)
      else
        List.last(transactions)
      end
    else
      raise "Expected transactions as ordered list type"
    end
  end

  def get_root(path, :file) do
    File.stream!(path)
    |> Enum.chunk_every(2)
    |> Enum.map(fn pair -> pair |> Enum.map(fn elem -> elem |> String.replace("\n", "") end) end)
    |> Enum.map(&hash_branch/1)
    |> get_root(:list)
  end

  # Concatenates single leaf (node) to itself, hashes the result with SHA256 and encodes it
  defp hash_branch([single_node]) do
    :crypto.hash(:sha256, Base.decode16!(single_node <> single_node, case: :mixed))
    |> Base.encode16(case: :lower)
  end

  # Concatenates left and right leaf (node), hashes the result with SHA256 and encodes it
  defp hash_branch([left_node, right_node]) do
    :crypto.hash(:sha256, Base.decode16!(left_node <> right_node, case: :mixed))
    |> Base.encode16(case: :lower)
  end
end
