defmodule InsertAndInorder do
  use Benchfella

  @list Enum.to_list(1..1_000) |> Enum.shuffle

  bench "tuple" do
    @list
    |> Enum.reduce(TupleBST.new, fn x, acc ->
      TupleBST.put(acc, x, x)
    end)
    |> TupleBST.inorder
  end

  bench "map" do
    @list
    |> Enum.reduce(MapBST.new, fn x, acc ->
      MapBST.put(acc, x, x)
    end)
    |> MapBST.inorder
  end
end
