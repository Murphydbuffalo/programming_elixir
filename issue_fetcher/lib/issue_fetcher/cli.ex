# Namespacing is done via `ModuleA.ModuleB`
defmodule IssueFetcher.CLI do
  require Logger

  @default_number_of_issues 5
  @moduledoc """
    This module handles parsing command line input for the issue fetcher. The
    user can enter in a GitHub username, repo, and optionally a number of issues
    to fetch.

    Returns a tuple of `{ :ok, username, project, count }` on success, or a help
    message on failure.
  """

  def main(argv) do
    argv
    |> parse_args
    |> IssueFetcher.Fetch.issues
    |> IssueFetcher.Format.issues
    |> IO.puts
  end

  def parse_args(argv) do
    case OptionParser.parse(argv) do
      { _, [username, project, number_of_issues], _ } -> { username, project, String.to_integer(number_of_issues) }
      { _, [username, project], _ } -> { username, project, @default_number_of_issues }
      _ ->

      message = """
        Please enter a GitHub username, repository name, and optionally, the
        number of issues to retrieve For example: `murphydbuffalo issue_fetcher 5`
      """
      Logger.info fn -> "#{message}\n}" end
      { :help, message }
    end
  end
end
