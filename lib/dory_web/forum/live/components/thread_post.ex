defmodule ThreadPost do
  use Surface.Component

  prop post, :map, required: true
  prop highlight, :boolean

  def render(assigns) do
    ~F"""
    <div data-hdl="post" class={if(@highlight, do: "bg-yellow-200", else: "") <> " flex flex-row"}>
      <div data-hdl="left" class="basis-1/6">
        <div data-hdl="icon" class="border-2 rounded mt-3 p-3">img</div>
      </div>
      <div data-hdl="right" class="basis-5/6 border-2 rounded m-3 p-3 bg-purple-200">
        <div data-hdl="top" class="flex flex-row">
          <div data-hdl="username">
            {@post.username}
          </div>
          <div data-hdl="time">
            {@post.created_at}
          </div>
        </div>
        <div data-hdl="body" class="border-t-2 mt-3 pt-3">
          {@post.body}
        </div>
      </div>
    </div>
    """
  end
end
