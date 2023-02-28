defmodule UI.Button do
  use Surface.Component
  import Tails

  prop disabled, :boolean, default: false
  prop class, :string, default: ""
  # prop phx_click, :string

  # data extra, :any

  slot default

  def render(assigns) do
    # extra =
    #   assigns_to_attributes(assigns, [
    #     :class,
    #     :disabled,
    #     :__caller_scope_id__,
    #     :__context__,
    #     :default
    #   ])

    # IO.inspect("-----------extra-----------")
    # IO.inspect(extra)

    ~F"""
    {!-- {...extra} --}
    <button
      {=@disabled}
      class={classes([
        "bg-blue-400 text-white font-bold py-2 px-4 rounded-xl",
        classes(
          "hover:bg-blue-600": !@disabled,
          "opacity-50 cursor-not-allowed": @disabled
        ),
        @class
      ])}
    >
      <#slot>{""}</#slot>
    </button>
    """
  end
end
