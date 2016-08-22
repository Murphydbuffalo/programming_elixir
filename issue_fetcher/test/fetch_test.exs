defmodule FetchTest do
  use ExUnit.Case
  doctest IssueFetcher

  test "passing in valid arguments returns a JSON list of GitHub issues" do
    { status, body, 10 } = IssueFetcher.Fetch.issues({ "elixir-lang", "elixir", 10})
    assert status == :ok
    assert is_list(body)
  end
end
