defmodule GitHelper.CLI do
  @spec main([String.t()]) :: any
  def main(args) do
    options = [strict: [review: :string]]
    {[{action, params}], _, _} = OptionParser.parse(args, options)

    case action do
      :review -> Mix.Tasks.Review.run(params)
    end
  end
end
