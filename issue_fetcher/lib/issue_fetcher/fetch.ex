defmodule IssueFetcher.Fetch do
  require Logger

  @derive [Poison.Parser]
  @github_url Application.get_env(:issue_fetcher, :github_url)
  @moduledoc """
    This module handles making HTTP requests to the GitHub API to retrieve ze issues.
  """

  def issues({ username, repo, number_of_issues }) do
    url = "#{@github_url}/#{username}/#{repo}/issues"
    Logger.info fn -> "Fetching #{number_of_issues} issues from #{url}...\n" end
    HTTPoison.get!(url) |> parse_response(number_of_issues)
  end

  def issues({ :help, _msg }), do: System.halt(0)

  defp parse_response(%{ status_code: 200, body: body, headers: _headers }, number_of_issues) do
    { :ok, Poison.Parser.parse!(body), number_of_issues }
  end

  defp parse_response(%{ status_code: code, body: body, headers: _headers }, _) do
    Logger.error fn -> "#{code} error: #{Poison.Parser.parse!(body)}\n" end
    System.halt(1)
  end
end
