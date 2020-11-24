defmodule Mix.Tasks.Review do
  @moduledoc "Review github PRs, sample, $mix review ashrafuzzaman:test_branch"
  @spec run(String.t) :: any
  def run(remote_and_branch) do
    unless remote_and_branch do
      IO.warn("Missing args <remote_name>:<branch>")
    else
      [remote_name, branch] = String.split(remote_and_branch, ":")
      repo_name = GitHelper.get_repo_name()

      if GitHelper.remote_exists?(remote_name) do
        IO.puts("The remote #{remote_name} is already there")
      else
        IO.puts("Adding remote #{remote_name}")
        GitHelper.add_remote!(remote_name)
      end

      IO.puts("Running Review script #{repo_name} #{remote_name}:#{branch}")
    end
  end
end
