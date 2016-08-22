defmodule SimpleList do
  def simple_length([]), do: 0
  def simple_length([_head | tail]), do: 1 + simple_length(tail)

  def simple_map([], _func), do: []
  def simple_map([head | tail], func), do: [func.(head) | simple_map(tail, func)]

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  # A common Elixir idiom is to use a private function of the same name as its public counterpart
  # when some intermediate result (state) needs to be passed between recursive function calls
  # The public function does not include the accumulator in its arity, and passes a hard-coded default
  # The private function (with multiple bodies) updates the accumulator argument behind the scenes
  # This type of state is fine; it is state that lasts only the length of the function calls
  # "state" as it is meant in an OOP context is persisted, and modified, between function calls
  def accumulator_sum(list), do: _accumulator_sum(list, 0)
  defp _accumulator_sum([], accumulator), do: accumulator
  defp _accumulator_sum([head | tail], accumulator), do: _accumulator_sum(tail, head + accumulator)
end
