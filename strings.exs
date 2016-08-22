defmodule FakeString do
  def ascii?([]), do: false
  def ascii?(list), do: all?(list, fn char -> char in 0..127 end)

  def anagram?(word1, word2) do
    charlist1 = to_charlist(word1)
    charlist2 = to_charlist(word2)

    Enum.sort(charlist1) == Enum.sort(charlist2)
  end

  def to_int(str) do
    parse_int(str, 0)
  end

  defp parse_int([], value), do: value
  defp parse_int([digit | tail], value) do
    parse_int(tail, (value * 10) + digit - ?0)
  end

  # '55 + 55' => 110
  def calculate(''), do: nil
  def calculate(string) do
    string_without_whitespace = for char <- string, char != ?\s, do: char
    parse_arithmetic_string(string_without_whitespace, [], [])
  end

  defp calculate_parsed_string([num1, ?/, num2]), do: num1 / num2
  defp calculate_parsed_string([num1, ?*, num2]), do: num1 * num2
  defp calculate_parsed_string([num1, ?+, num2]), do: num1 + num2
  defp calculate_parsed_string([num1, ?-, num2]), do: num1 - num2

  defp parse_arithmetic_string([head | tail], intermediate_values, final_values) when head in '1234567890' do
    parse_arithmetic_string(tail, [head | intermediate_values], final_values)
  end

  defp parse_arithmetic_string([head | tail], intermediate_values, []) when head in [?+, ?-, ?*, ?/] do
    operand1 = Enum.reverse(intermediate_values) |> parse_int(0)
    parse_arithmetic_string(tail, [], [head, operand1])
  end

  defp parse_arithmetic_string([], intermediate_values, final_values) do
    operand2 = Enum.reverse(intermediate_values) |> parse_int(0)
    calculate_parsed_string(Enum.reverse([operand2 | final_values]))
  end

  # "hi. tHEre. frieNd." => "Hi. There. Friend."
  def capitalize_sentences(str) do
    String.split(str, ". ") |> Enum.map(&(String.capitalize(&1))) |> Enum.join(". ")
  end

  # Return a keyword list
  # id,ship_to,net_amount
  # 1,:NC,100.00
  # ...
  # => [{ id: 1 }, { ship_to: :NC }, { net_amount: 100.00 }]
  def parse_csv(str) do
    [headers_string | rows_strings] = String.split(str, "\n")
    [id_key, ship_to_key, net_amount_key] = String.split(headers_string, ",") |> Enum.map(&(String.to_atom(&1)))
    rows = Enum.map(rows_strings, &(String.split(&1, ",")))

    for [id, ship_to, net_amount] <- rows do
      [{ id_key, id }, { ship_to_key, ship_to }, { net_amount_key, net_amount }]
    end
  end

  # Just for practice, could use `Enum.all?`
  defp all?([], _func), do: false
  defp all?([last_element], func), do: func.(last_element)
  defp all?([head | tail], func) do
    if func.(head), do: all?(tail, func), else: false
  end
end
