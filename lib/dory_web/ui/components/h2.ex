defmodule UI.H2 do
  use Surface.Component
  import Tails

  prop class, :string, default: ""

  slot default, required: true

  def render(assigns) do
    ~F"""
    <h2 class={classes(["text-blue-500 text-xl font-bold", @class])}>
      <#slot />
    </h2>
    """
  end
end
