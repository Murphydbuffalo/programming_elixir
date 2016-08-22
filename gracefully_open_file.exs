gracefully_read_file = fn
  { :ok, file } -> "First line in file is #{IO.read(file, :line)}"
  { _, error } -> "Error: #{:file.format_error(error)}"
end

IO.puts(gracefully_read_file.(File.open("hello_world.exs")))
IO.puts(gracefully_read_file.(File.open("foo.exs")))
