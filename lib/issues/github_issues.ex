defmodule Issues.GitHubIssues do
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    url(user, project)
      |> HTTPoison.get([ {"User-agent", "Elixir dave@pragprog.com"} ])
      |> handle_response
  end

  def url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end
  defp check_for_error(200) do :ok end
  defp check_for_error(_) do :error end
end
