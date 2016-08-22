defmodule ProcessChain do
  def start_chain(n) do
    start_pid = Enum.reduce 1..n, self, fn (_n, next_pid)->
      spawn(__MODULE__, :increment_counter, [next_pid])
    end

    send(start_pid, 0)

    receive do
      final_result when is_integer(final_result) ->
        "All done! Final answer is #{final_result}."
    end
  end

  def increment_counter(pid) do
    receive do
      number ->
        send(pid, number + 1)
    end
  end

  def run(n) do
    IO.inspect :timer.tc(__MODULE__, :start_chain, [n])
  end
end
