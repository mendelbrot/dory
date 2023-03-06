defmodule Forum.Post do
  use Surface.Component
  alias Forum.PostFrame

  prop post, :map, required: true
  prop highlight, :boolean

  slot default

  def render(assigns) do
    ~F"""
    <div
      data-hdl="post"
      class={if(@highlight, do: "bg-yellow-200", else: "") <> " flex flex-row p-3"}
      phx-click="select-post"
      phx-value-id={@post.id}
      phx-value-ref_post_id={@post.ref_post_id}
    >
      <div data-hdl="left" class="">
        <Profile.Icon src="https://cdn-icons-png.flaticon.com/128/3069/3069186.png" />
      </div>
      <PostFrame>
        <div>
          <div data-hdl="top" class="pb-3 flex flex-row">
            <div data-hdl="username">
              {@post.username}
            </div>
            <div data-hdl="time">
              {@post.created_at}
            </div>
          </div>
          <div data-hdl="body" class="border-t-2 py-3 border-blue-400">
            {@post.body}
          </div>
          <#slot />
        </div>
      </PostFrame>
    </div>
    """
  end
end
