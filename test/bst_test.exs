defmodule TupleBSTTest do
  use ExUnit.Case, async: true
  use Quixir

  test "TupleBST puts and inorder" do
    ptest xs: list(of: int(min: 1, max: 5000)) do
      bst = Enum.reduce(xs, TupleBST.new, fn x, acc ->
        TupleBST.put(acc, x, x)
      end)
      assert TupleBST.inorder(bst) == Enum.uniq(Enum.sort(Enum.zip(xs, xs)))
    end
  end

  test "MapBST puts and inorder" do
    ptest xs: list(of: int(min: 1, max: 5000)) do
      bst = Enum.reduce(xs, MapBST.new, fn x, acc ->
        MapBST.put(acc, x, x)
      end)
      assert MapBST.inorder(bst) == Enum.uniq(Enum.sort(Enum.zip(xs, xs)))
    end
  end
end
