defmodule Mix.Tasks.Review do
  use Mix.Task

  @moduledoc "Review github PRs, sample, $mix review ashrafuzzaman:test_branch"
  @shortdoc "Review github PRs"

  def run(args) do
    origin_branch = List.first(args)
    shell = Mix.shell()
    unless origin_branch do
      shell.error("Missing args <origin>:<branch>")
    else
      [origin, branch] = String.split(origin_branch, ":")
      shell.info("Running Review script #{origin}:#{branch}")
    end
  end
end
