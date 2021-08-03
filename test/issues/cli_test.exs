defmodule Issues.CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort descending orders the correct way" do
    r = ["a", "c", "b"]
      |> Enum.map(&(%{created_at: &1, other: "XXX"}))
      |> sort_into_descending_order
      |> Enum.map(&(&1.created_at))

    assert r == ["c", "b", "a"]
  end
end
