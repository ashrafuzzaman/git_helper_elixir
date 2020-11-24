defmodule GitHelper.CLI do
  @spec main([String.t()]) :: any
  def main(args) do
    options = [strict: [review: :string]]
    {opts, _, _} = OptionParser.parse(args, options)

    if opts[:review] do
      Mix.Tasks.Review.run(opts[:review])
    end
  end
end
