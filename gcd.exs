# Examples:
# gcd(10, 15) => 5
# gcd(21, 42) => 21
# gcd(10, 0) => 10
defmodule GreatestCommonDivisor do
  def of(x, 0), do: x
  def of(x, y), do: GreatestCommonDivisor.of(y, rem(x, y))
end
