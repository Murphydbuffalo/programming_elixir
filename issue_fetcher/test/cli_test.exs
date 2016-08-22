defmodule CliTest do
  use ExUnit.Case
  doctest IssueFetcher

  test "command line arguments are parsed correctly" do
    parsed_args = IssueFetcher.CLI.parse_args(~w(murphydbuffalo issue_fetcher 7))
    assert parsed_args == { "murphydbuffalo", "issue_fetcher", 7 }
  end

  test "default value for the number of issues to be returned" do
    parsed_args = IssueFetcher.CLI.parse_args(~w(murphydbuffalo issue_fetcher))
    assert parsed_args == { "murphydbuffalo", "issue_fetcher", 5 }
  end

  test "the help message" do
    parsed_args = IssueFetcher.CLI.parse_args(~w(--help))
    message = """
      Please enter a GitHub username, repository name, and optionally, the
      number of issues to retrieve For example: `murphydbuffalo issue_fetcher 5`
    """
    assert parsed_args == { :help, message }
  end
end
