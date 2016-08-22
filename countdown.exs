# Streams are great for working with large collections
# You don't need to load the entire thing into memory: instead you get to work
# with only as many values as you need (for example, by using Enum.take)
defmodule Countdown do
  def from(number, phrase \\ 'Aww shucky ducky!') do
    Stream.iterate(number, &(&1 - 1)) |> Enum.take(number + 1) |> Enum.map(
      fn
        0 -> say(phrase)
        number ->
          say(number)
          sleep(1)
      end
    )
  end

  defp sleep(seconds) do
    receive do
      after seconds * 1000 -> :done
    end
  end

  defp say(phrase) do
    spawn fn -> :os.cmd('say #{phrase}') end
  end
end
