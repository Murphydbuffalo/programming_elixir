defmodule Comprehension do
  def primes_to(n) when n < 2, do: IO.puts("Please enter an integer greater than 2")
  def primes_to(n) do
    for number <- 2..n, prime?(number), do: number
  end

  defp prime?(number) when number < 1, do: IO.puts("Please enter a positive integer")
  defp prime?(number) when number < 3, do: true
  defp prime?(number) do
    2..(number - 1) |> Enum.all?(&(!divisible_by?(number, &1)))
  end

  defp divisible_by?(number, divisor), do: rem(number, divisor) == 0

  @tax_rates [NC: 0.075, TX: 0.08]
  @orders [
    [id: 123, ship_to: :NC, net_amount: 100.00],
    [id: 124, ship_to: :OK, net_amount: 25.50],
    [id: 124, ship_to: :TX, net_amount: 33.33],
    [id: 124, ship_to: :MA, net_amount: 45.20],
    [id: 124, ship_to: :NY, net_amount: 87.50],
    [id: 124, ship_to: :NC, net_amount: 21.25],
    [id: 124, ship_to: :CA, net_amount: 99.99],
    [id: 124, ship_to: :TX, net_amount: 51.00],
    [id: 124, ship_to: :RI, net_amount: 37.33],
    [id: 124, ship_to: :DE, net_amount: 67.23]
  ]

  def tax_rates, do: @tax_rates
  def orders, do: @orders
  def orders_with_tax do
    for order <- orders, {tax_destination, tax_rate} <- tax_rates do
      tax_added =
        if order[:ship_to] == tax_destination do
          tax_rate
        else
          0
        end

      order ++ [total_amount: order[:net_amount] + tax_added]
    end
  end
end
