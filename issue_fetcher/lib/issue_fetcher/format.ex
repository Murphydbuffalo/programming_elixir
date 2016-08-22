defmodule IssueFetcher.Format do
  @moduledoc """
    Format JSON responses from the GitHub API into pretty string tables. Eg:
    ```
    created_at           | id | title
    2016-08-13T20:30:15Z | 1  | Everbody, let's go everybody!
    ```
  """
  @column_names ~w(created_at id title)

  def issues({ :ok, json, number_of_issues }) do
    json
    |> Enum.take(number_of_issues)
    |> Enum.map(&(Map.take(&1, @column_names)))
    |> to_table
  end

  defp to_table(maps) do
    [headers(maps)] ++ rows(maps) |> Enum.join("\n")
  end

  defp headers(maps) do
    names_with_widths = Enum.zip(@column_names, column_widths(maps))
    strings = for { name, width } <- names_with_widths, do: String.pad_trailing(name, width)
    Enum.join(strings, " | ")
  end

  defp rows(maps) do
    maps
    |> Enum.map(&(Map.values(&1)))
    |> Enum.join(" | ")
  end

  defp column_widths(maps) do
    for column_name <- @column_names do
      maps
      |> Enum.map(&(&1[column_name] |> to_string |> String.length))
    end
    |> Enum.map(&(Enum.max(&1)))
  end
end
