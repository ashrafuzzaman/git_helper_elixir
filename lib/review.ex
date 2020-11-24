defmodule Mix.Tasks.Review do
  use Mix.Task

  @moduledoc "Review github PRs, sample, $mix review ashrafuzzaman:test_branch"
  @shortdoc "Review github PRs"
  @spec run([String.t]) :: any
  def run(args) do
    remote_and_branch = List.first(args)
    shell = Mix.shell()

    unless remote_and_branch do
      shell.error("Missing args <remote_name>:<branch>")
    else
      [remote_name, branch] = String.split(remote_and_branch, ":")
      repo_name = GitHelper.get_repo_name()

      if GitHelper.remote_exists?(remote_name) do
        shell.info("The remote #{remote_name} is already there")
      else
        shell.info("Adding remote #{remote_name}")
        GitHelper.add_remote!(remote_name)
      end

      shell.info("Running Review script #{repo_name} #{remote_name}:#{branch}")
    end
  end
end
