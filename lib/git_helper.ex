defmodule GitHelper do
  def _get_repo() do
    Git.new()
  end

  @spec get_all_remotes :: [String.t]
  def get_all_remotes() do
    remote_line_regex = ~r/.+\t(?<remote>git@github\.com\:.+\/.+\.git)/

    Git.remote!(_get_repo(), "-v")
    |> String.split("\n")
    |> Enum.map(fn line -> Regex.named_captures(remote_line_regex, line)["remote"] end)
    |> Enum.filter(fn remote -> remote end)
    |> Enum.uniq()
  end

  @spec remote_exists?(remote_name :: String.t) :: boolean
  def remote_exists?(remote_name) do
    get_all_remotes()
    |> Enum.any?(fn remote -> String.contains?(remote, remote_name) end)
  end

  @spec add_remote!(remote_name :: String.t) :: binary
  def add_remote!(remote_name) do
    Git.remote!(_get_repo(), ["add", remote_name, get_repo_url(remote_name)])
  end

  @spec checkout_branch!(remote_name :: String.t, branch :: String.t) :: binary
  def checkout_branch!(remote_name, branch) do
    repo = _get_repo()
    Git.fetch!(repo, [remote_name, branch])
    Git.checkout!(repo, ["-t", "#{remote_name}/#{branch}"])
  end

  @spec get_repo_name :: String.t
  def get_repo_name() do
    get_all_remotes()
    |> Enum.at(0)
    |> (&Regex.named_captures(~r/git@github\.com\:.+\/(?<repo>.+)\.git/, &1)["repo"]).()
  end

  @spec get_repo_url(String.t) :: String.t
  def get_repo_url(remote_name) do
    "git@github.com:#{remote_name}/#{get_repo_name()}.git"
  end

  @spec checkout!(remote_name :: String.t, branch :: String.t) :: binary
  def checkout!(remote_name, branch) do
    Git.checkout!(_get_repo(), ["-t", "#{remote_name}/#{branch}"])
  end
end
