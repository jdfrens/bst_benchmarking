defmodule TupleBST do
  @empty {}

  def new, do: @empty

  def put(@empty, key, val), do: build({key, val})
  def put({{k, v}, l, r}, key, val) do
    cond do
      key < k ->
        build({k,v}, put(l, key, val), r)
      k < key ->
        build({k, v}, l, put(r, key, val))
      true ->
        build({k, val}, l, r)
    end
  end

  defp build(kv), do: build(kv, @empty, @empty)
  defp build(kv, l, r), do: {kv, l, r}

  def inorder(bst), do: Enum.reverse(inorder(bst, []))
  defp inorder(@empty, acc), do: acc
  defp inorder({kv, l, r}, acc) do
    inorder(r, [kv | inorder(l, acc)])
  end
end
