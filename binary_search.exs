defmodule BinarySearch do
  def for(number, min..max = range) when number == min + div(max - min, 2) do
    print_search(number, range)
    result = min + div(max - min, 2)
    IO.puts("Found it! #{result}")
  end

  def for(number, min..max = range) when number < min + div(max - min, 2) do
    print_search(number, range)
    BinarySearch.for(number, lower_half(range))
  end

  def for(number, min..max = range) when number > min + div(max - min, 2) do
    print_search(number, range)
    BinarySearch.for(number, upper_half(range))
  end

  defp lower_half(min..max = _range) do
    new_max = min + div(max - min, 2) - 1
    min..new_max
  end

  defp upper_half(min..max = _range) do
    new_min = min + div(max - min, 2) + 1
    new_min..max
  end

  defp print_search(number, min..max = _range), do: IO.puts("Looking for #{number}. Is it #{min + div(max - min, 2)}?")
end
