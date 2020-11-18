defmodule Mix.Tasks.ReviewTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  describe "run/1" do
    test "prints a valid JWT" do
      outout = capture_io(fn ->
        Mix.Tasks.Review.run(["ashrafuzzaman:test_branch"])
      end) |> String.trim

      assert outout === "Running Review script ashrafuzzaman:test_branch"
    end
  end
end
