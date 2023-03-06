defmodule Forum.PostFrame do
  use Surface.Component

  slot default, required: true

  def render(assigns) do
    ~F"""
    <div class="border-2 rounded ml-3 p-3 bg-purple-200 border-blue-400">
      <#slot />
    </div>
    """
  end
end
