# MerkleRoot

`MerkleRoot` is a micro library for getting Merkle root from the hex-encoded transactions.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `merkle_root` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:merkle_root, "~> 0.1.0"}
  ]
end
```

## How to run

- Clone repo:

```sh
git clone https://github.com/fanna/merkle_root.git 
cd merkle_root
```
- Get all dependencies:

```sh
mix deps.get
```

- Compile application and run interactive shell:
```sh
iex -S mix
```

```sh
# Getting Merkle root from the file containing hex-encoded transactions
iex> MerkleRoot.get_root("./input.txt", :file)

# or getting Merkle root from the ordered list which contains hex-encoded transactions
iex> MerkleRoot.get_root(["77d519a56a3bb197bca02ed25f880a122487914556d587588e633c8368d13053", "915961583d426ff5d6726ee59ff7e1ad234d8343f60c57ab023b21741fdba723"], :list)

# Benchmarking the solution
iex> Benchmark.measure(fn -> MerkleRoot.get_root("./input.txt", :file) end)
```

## Testing

For running tests:
```sh
mix test
```

### Potential improvements

Structuring the code so that it can utilize the [Flow](https://hexdocs.pm/flow/Flow.html) library for paralalelizing processing of transactions and their hashing.