defmodule Receiver do
  def respond do
    # The process will exit (or at least stop functioning) after completing its
    # `receive` block, so be sure to recurse *within* that receive block!
    receive do
      { sender_pid, message } ->
        send sender_pid, { self, "Message received!\n#{message}\n" }
        respond
      # after 500 ->
      #   IO.puts "Something's gone wrong in Reciever :("
      #   exit(self)
    end
  end
end

receiver_pid = spawn(Receiver, :respond, [])
IO.puts "About to send a message to Reciever...\n"
send receiver_pid, { self, "Hello out there!" }

receive do
  { _receiver_pid, response} ->
    IO.puts "Response from Receiver:\n#{response}\n"
  after 500 ->
    IO.puts "Something went wrong in Sender :("
    exit(self)
end

send receiver_pid, { self, "Hello again!" }

receive do
  { _receiver_pid, response} ->
    IO.puts "Response recieved:\n#{response}"
  after 500 ->
    IO.puts "Something went wrong in Sender :("
    exit(self)
end
