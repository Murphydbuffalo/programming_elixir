defmodule WeatherData do
  def example_data do
    [
      [20160527, 1, "Sunny"],
      [20160528, 4, "Rainy"],
      [20160528, 1, "Rainy"],
      [20160529, 3, "Sunny"],
      [20160530, 9, "Cloudy"],
      [20160531, 7, "Sunny"],
      [20160531, 1, "World engulfed in flames!"],
      [20160601, 11, "Sunny"]
    ]
  end

  def for_location(_id, []), do: []
  def for_location(id, [head = [_, id, _] | tail]) do
    IO.puts("Found entry with matching id!")
    [head | for_location(id, tail)]
  end
  def for_location(id, [_ | tail]), do: for_location(id, tail)
end
