defmodule CaesarCypher do
  def encrypt(string, shift) do
    string |> characters |> shifted_characters(shift) |> Enum.join
  end

  defp characters(string), do: String.split(string, "", trim: true)

  defp shifted_characters([], _shift), do: []
  defp shifted_characters([head | tail], shift) do
    <<codepoint::utf8>> = head
    [ <<(codepoint + shift)::utf8>> | shifted_characters(tail, shift)]
  end
end
