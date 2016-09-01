# defmodule EmptyMapBST do
#   defstruct empty: true
# end

defmodule MapBST do
  defstruct empty: false, key: nil, value: nil, left: nil, right: nil

  def new do
    %MapBST{empty: true}
  end

  def put(%MapBST{empty: true} = bst, key, val) do
    %MapBST{key: key, value: val, left: bst, right: bst}
  end
  def put(%MapBST{key: k, value: v, left: l, right: r}, key, val) do
    cond do
      key < k ->
        %MapBST{key: k, value: v, left: put(l, key, val), right: r}
      k < key ->
        %MapBST{key: k, value: v, left: l, right: put(r, key, val)}
      true ->
        %MapBST{key: k, value: val, left: l, right: r}
    end
  end

  def inorder(bst), do: Enum.reverse(inorder(bst, []))
  defp inorder(%MapBST{empty: true}, acc), do: acc
  defp inorder(%MapBST{key: k, value: v, left: l, right: r}, acc) do
    inorder(r, [{k, v} | inorder(l, acc)])
  end
end

# defimpl String.Chars, for: EmptyMapBST do
#   def to_string(_), do: "[]"
# end

defimpl String.Chars, for: MapBST do
  def to_string(bst) do
    elements =
      bst
      |> MapBST.inorder
      |> Enum.map_join(", ", fn {k, v} -> "{#{k}, #{v}}" end)
      |> Kernel.to_string
    "[#{elements}]"
  end
end
