defmodule Reducer do
  def reduce([]), do: []
  def reduce([], accumulator, _func), do: accumulator
  def reduce([head | tail], accumulator, func), do: reduce(tail, func.(head, accumulator), func)

  def mapsum([]), do: []
  def mapsum([], accumulator, _func), do: accumulator
  def mapsum([head | tail], accumulator, func), do: mapsum(tail, (func.(head) + accumulator), func)

  def max_from_list([]), do: _max_from_list([], [])
  def max_from_list([head | tail]), do: _max_from_list(tail, max_from_pair(head, nil))

  defp _max_from_list([], value), do: value
  defp _max_from_list([head | tail], value), do: _max_from_list(tail, max_from_pair(head, value))

  defp max_from_pair(value1, value2) when is_nil(value2), do: value1
  defp max_from_pair(value1, value2) when value1 >= value2, do: value1
  defp max_from_pair(value1, value2) when value1 < value2, do: value2
end
