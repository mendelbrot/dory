defmodule Forum.Post do
  use Surface.Component

  prop post, :map, required: true

  def render(assigns) do
    ~F"""
    <div
      data-hdl="post"
      class="flex flex-row p-3"
      phx-click="select-post"
      phx-value-id={@post.id}
      phx-value-ref_post_id={@post.ref_post_id}
    >
      <div data-hdl="left" class="basis-1/6">
        <Profile.Icon src="https://cdn-icons-png.flaticon.com/128/3069/3069186.png" />
      </div>
      <div data-hdl="right" class="basis-5/6 border-2 rounded ml-3 p-3">
        <div data-hdl="top" class="flex flex-row">
          <div data-hdl="username">
            {@post.username}
          </div>
          <div data-hdl="time">
            {@post.created_at}
          </div>
        </div>
        <div data-hdl="body" class="border-y-2 my-3 py-3">
          {@post.body}
        </div>
        <div data-hdl="bottom" class="flex flex-row">
          <div data-hdl="icons" class="flex flex-row">
            <div data-hdl="icon">img</div>
            <div data-hdl="icon">img</div>
          </div>
          <div data-hdl="replies">10 replies</div>
          <div data-hdl="last-reply">last reply today</div>
        </div>
      </div>
    </div>
    """
  end
end
