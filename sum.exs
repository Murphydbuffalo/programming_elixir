defmodule Sum do
  def of(0), do: 0
  def of(n), do: n + Sum.of(n - 1)
end
