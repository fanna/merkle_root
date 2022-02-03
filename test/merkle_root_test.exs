defmodule MerkleRootTest do
  use ExUnit.Case
  doctest MerkleRoot

  test "reads odd number of hex-encoded transactions from file and returns correct merkle root" do
    path = "./test/fixtures/odd_test_input.txt"
    assert MerkleRoot.get_root(path, :file) == "d318f40363d14d53a7cf34330468bfaaa993be66e53049a3d7e132647bce66a6"
  end

  test "reads even number of hex-encoded transactions from file and returns correct merkle root" do
    path = "./test/fixtures/even_test_input.txt"
    assert MerkleRoot.get_root(path, :file) == "4cb784cc0fcfcbe2e9f7602ed4a6d0ac853271a2a38c6480c6d6e565fce7487d"
  end

  test "returns merkle root from odd number of hex-encoded transactions list" do
    transactions = [
      "77d519a56a3bb197bca02ed25f880a122487914556d587588e633c8368d13053",
      "915961583d426ff5d6726ee59ff7e1ad234d8343f60c57ab023b21741fdba723",
      "7a172559f818c9d9f750b20f9fb16ed89879df47c20e03ffeaa3026c1d297646"
    ]
    assert MerkleRoot.get_root(transactions, :list) == "f635de0509854cee47184a166eba580b37f9c64ad7e1bfe9c74cd3bb17119cdb"
  end

  test "returns merkle root from even number of hex-encoded transactions list" do
    transactions = [
      "77d519a56a3bb197bca02ed25f880a122487914556d587588e633c8368d13053",
      "915961583d426ff5d6726ee59ff7e1ad234d8343f60c57ab023b21741fdba723"
    ]
    assert MerkleRoot.get_root(transactions, :list) == "5499d81fefae464c5ddf17f937b7313111aa04e59efece0b172d7b5363b05c81"
  end

  test "raises error if input is not a list" do
    assert_raise RuntimeError, "Expected transactions as ordered list type", fn -> MerkleRoot.get_root("a", :list) end
  end

  test "raises error if input is not a valid file path string" do
    assert_raise File.Error, fn -> MerkleRoot.get_root("a", :file) end
  end
end
