prefix = fn(string) -> (fn (second_string) -> "#{string} #{second_string}" end) end
prefix_dan = prefix.("Dan")
IO.puts(prefix_dan.("Murphy"))
