defmodule Benchmark do
  @moduledoc """
  `Benchmark` is minimal module which has a single `measure` function for displayign the speed of specified function.
  """

  @doc """
  Measures the function execution speed
  Iput is a function
  """
  def measure(function) do
    result = function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)

    IO.puts "#{result} seconds"
  end
end
