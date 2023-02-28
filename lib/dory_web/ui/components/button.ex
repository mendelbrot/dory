defmodule UI.Button do
  @moduledoc """
  a basic button.

  - the 'class' prop overrides the styles.
  - the 'on_click' prop is passed down to phx-click.
  - the 'disabled' and 'id' props are passed down.
  - the 'disabled' prop alters the styling.

  example:
  ```
    <UI.Button
      on_click="save"
      disabled={!can_submit}
      class="bg-fuchsia-400 hover:bg-fuchsia-600 my-3"
    >
      Save
    </UI.Button>
  ```
  """
  use Surface.Component
  import Tails

  prop id, :string
  prop disabled, :boolean, default: false
  prop on_click, :string
  prop class, :string, default: ""

  slot default

  def render(assigns) do
    ~F"""
    <button
      {=@id}
      {=@disabled}
      phx-click={@on_click}
      class={classes([
        "bg-blue-400 text-white font-bold py-2 px-4 rounded-xl",
        [
          "hover:bg-blue-600": !@disabled,
          "opacity-50 cursor-not-allowed": @disabled
        ],
        @class
      ])}
    >
      <#slot />
    </button>
    """
  end
end
