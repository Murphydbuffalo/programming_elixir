defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting}, #{name}"
      (_) -> "I don't know you"
    end
  end
end

dan_greeter = Greeter.for("Dan", "Hi")
IO.puts(dan_greeter.("Dan"))
IO.puts(dan_greeter.("Bob"))
