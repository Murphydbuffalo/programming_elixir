defmodule FakeEnum do
  def all?([], _func), do: false
  def all?(collection, func), do: _all?(collection, func, true)

  defp _all?([], _func, accumulator), do: accumulator
  defp _all?([head | tail], func, _accumulator = true), do: _all?(tail, func, func.(head))
  defp _all?(_, _, _), do: false

  def each([], _), do: []
  def each([head | tail], func), do: [func.(head) | each(tail, func)]

  def take([], _n), do: []
  def take(collection, n), do: _take(collection, n, 0)

  defp _take([head | tail], n, index) when index < n, do: [head | _take(tail, n, index + 1)]
  defp _take([_head | _tail], n, index) when index >= n, do: []
  defp _take([], _n, _index), do: []

  def skip([], _n), do: []
  def skip(collection, n), do: _skip(collection, n, 0)

  defp _skip([head | tail], n, index) when index >= n, do: [head | _skip(tail, n, index + 1)]
  defp _skip([_head | tail], n, index) when index < n, do: _skip(tail, n, index + 1)
  defp _skip([], _n, _index), do: []

  # FakeEnum.split(list, index) => bifurcate a list at a given index
  # list = [1, 2, 3, 4, 5]
  # FakeEnum.split(list, 2) => { [1, 2, 3], [4, 5] }
  def split([], _n), do: { [], [] }
  def split(collection, n), do: { take(collection, n), skip(collection, n) }

  def filter([], _func), do: []
  def filter(collection, func), do: _filter(collection, func)

  defp _filter([head | tail], func) do
    if func.(head) do
      [head | _filter(tail, func)]
    else
      _filter(tail, func)
    end
  end

  defp _filter([], _func), do: []

  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head) do
    [heads_head | heads_tail] = head
    [heads_head | flatten(heads_tail ++ tail)]
  end

  def flatten([head | tail]) do
    [head | flatten(tail)]
  end
end
