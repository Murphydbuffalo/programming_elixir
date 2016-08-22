# Given an integer, if divisible by 3 return "Fizz", if divisible by 5 return "Buzz"
# If divisible by both 3 and 5, return "Fizz Buzz"
fizz_buzz = fn
  [0, 0, _] -> "Fizz Buzz"
  [0, _, _] -> "Fizz"
  [_, 0, _] -> "Buzz"
  [_, _, num] -> num
end

remainders = fn(n) -> [rem(n, 3), rem(n, 5), n] end

IO.puts(fizz_buzz.(remainders.(6)))
IO.puts(fizz_buzz.(remainders.(10)))
IO.puts(fizz_buzz.(remainders.(15)))
IO.puts(fizz_buzz.(remainders.(2)))
