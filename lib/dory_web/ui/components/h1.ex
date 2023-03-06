defmodule UI.H1 do
  use Surface.Component
  import Tails

  prop class, :string, default: ""

  slot default, required: true

  def render(assigns) do
    ~F"""
    <h1 class={classes(["text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2 outline-2", @class])}>
      <#slot />
    </h1>
    """
  end
end
