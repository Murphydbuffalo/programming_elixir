defmodule Practice do
  def flatten([]), do: []

  def flatten([subarray = [_head | _tail] | tail]) do
    flatten(subarray) ++ flatten(tail)
  end

  def flatten([head | tail]) do
    [head | flatten(tail)]
  end

  def any?([], _predicate), do: false

  def any?([head | tail], predicate) do
    predicate.(head) || any?(tail, predicate)
  end

  def length([]), do: 0

  def length(list = [_head | _tail]) do
    length_with_accumulator(list, 0)
  end

  defp length_with_accumulator([], accumulator), do: accumulator

  defp length_with_accumulator([_head | tail], accumulator) do
    length_with_accumulator(tail, accumulator + 1)
  end

  def filter([], _predicate), do: []

  def filter([head | tail], predicate) do
    if predicate.(head) do
      [head | filter(tail, predicate)]
    else
      filter(tail, predicate)
    end
  end

  # quicksort -
  # Recursively split a list into two parts separated by a "pivot" element.
  # All elements smaller than the pivot in the first part
  # and all elements greater than the pivot in the second.
  # A true quicksort shuffles the list before sorting.
  # [a d j e z l e a]
  # [a] ++ [a] ++ [d j e z l e]
  # [a] ++ [a] ++ ([] ++ [d] ++ [j e z l e])
  # [a] ++ [a] ++ ([] ++ [d] ++ ([e e] ++ [j] ++ [z l])])
  # [a] ++ [a] ++ ([] ++ [d] ++ (([e] ++ [e] ++ []) ++ [j] ++ ([l] ++ [z] ++ []))])
  # => [a, a, d, e, e, j, l, z]
  def quicksort([]), do: []
  def quicksort([head | tail]) do
    # Below are "list comprehensions" -- a concise syntax for filtering and
    # mapping values in a list. The syntax is:
    # `for some_element <- some_list, some_condition, do: some_function`
    # => a list where elements met the condition, passed through the function
    # lesser = for each <- tail, each <= head, do: each
    # greater = for  each <- tail, each > head, do: each
    lesser = filter(tail, &(&1 <= head))
    greater = filter(tail, &(&1 > head))
    quicksort(lesser) ++ [head] ++ quicksort(greater)
  end

  # mergesort ("top down") -
  # Implement a function to combine two sorted lists into one sorted list
  # Divide a list into two lists, and call your "merge and sort" function
  # using the result of those two lists passed to `mergesort` (recursion)
  # [a d j e z l e a] (mergesort called)
  # [a, d, j, e] [z, l, e, a] (merge_and_sort called on the result of mergesort called on both halves)
  # [a, d] [j, e] [z, l] [e, a]
  # [a] [d] [j] [e] [z] [l] [e] [a]
  # [a, d] [e, j] [l] [z] [a] [e]
  # [a, d, e, j] [a, e, l, z]
  # => [a, a, d, e, e, l, z]
  def mergesort([]), do: []
  def mergesort([a]), do: [a]
  def mergesort(list = [_head | _tail]) do
    { list1, list2 } = split(list, div(Practice.length(list), 2))
    merge_and_sort(mergesort(list1), mergesort(list2))
  end

  def split([], _at), do: []
  def split(list, at) do
    { take(list, at), skip(list, at) }
  end

  def take(list, until) do
    take_with_index(list, until, 0)
  end

  def skip(list, from) do
    skip_with_index(list, from, 0)
  end

  defp take_with_index([], _up_to, _index), do: []

  defp take_with_index([head | tail], up_to, index) when index < up_to do
    [head | take_with_index(tail, up_to, index + 1)]
  end

  defp take_with_index([_head | _tail], _up_to, _index), do: []

  defp skip_with_index([], _starting_from, _index), do: []

  defp skip_with_index([head | tail], starting_from, index) when index >= starting_from do
    [head | skip_with_index(tail, starting_from, index + 1)]
  end

  defp skip_with_index([_head | tail], starting_from, index) do
    skip_with_index(tail, starting_from, index + 1)
  end

  # Will combine two sorted lists into one sorted list
  def merge_and_sort([], list2), do: list2
  def merge_and_sort(list1, []), do: list1
  def merge_and_sort(list1 = [head1 | tail1], list2 = [head2 | tail2]) do
    if head1 <= head2 do
      [head1 | merge_and_sort(tail1, list2)]
    else
      [head2 | merge_and_sort(tail2, list1)]
    end
  end

  def reverse([]), do: []
  def reverse(list = [_head | _tail]) do
    reverse_with_accumulator(list, [])
  end

  defp reverse_with_accumulator([], accumulator), do: accumulator
  defp reverse_with_accumulator([head | tail], accumulator) do
    reverse_with_accumulator(tail, [head | accumulator])
  end
end
