defmodule DoryWeb.ForumLive do
  use DoryWeb, :live_view

  def mount(_params, _session, socket) do
    posts = [
      %{
        id: "123",
        user_id: "234",
        username: "abc",
        user_icon: "/images/user_icons/123.png",
        created_at: "2022-08-11 21:06:17+03",
        updated_at: "2022-08-11 21:06:17+03",
        ref_post_id: nil,
        body: "hello 👋 this is a post 😃"
      },
      %{
        id: "543",
        user_id: "1",
        username: "cba",
        created_at: "2023-08-11 21:06:17+03",
        updated_at: "2023-08-11 21:06:17+03",
        ref_post_id: "123",
        body: "hi there.  this is neat. 💚"
      }
    ]

    socket = assign(socket, posts: posts)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2 outline-2">Forum</h1>
    <div class="inline-grid grid-cols-2 gap-px">
      <div class="p-3 outline outline-1">
        <div data-hdl="posts-header">
          <h2 class="text-green-500 text-xl font-bold">Posts</h2>
        </div>
      </div>
      <div class="p-3 outline outline-1">
        <div data-hdl="thread-header">
          <h2 class="text-blue-500 text-xl font-bold">Thread</h2>
        </div>
      </div>
      <div class="p-3 outline outline-1">
        <ul data-hdl="posts">
          <li :for={m <- @posts}>
            <div data-hdl="post" class="flex flex-row">
              <div data-hdl="left" class="basis-1/6">
                <div data-hdl="icon" class="border-2 rounded mt-3 p-3">img</div>
              </div>
              <div data-hdl="right" class="basis-5/6 border-2 rounded m-3 p-3">
                <div data-hdl="top" class="flex flex-row">
                  <div data-hdl="username">
                    <%= m.username %>
                  </div>
                  <div data-hdl="time">
                    <%= m.created_at %>
                  </div>
                </div>
                <div ata-hdl="body" class="border-y-2 my-3 py-3">
                  <%= m.body %>
                </div>
                <div ata-hdl="bottom" class="flex flex-row">
                  <div ata-hdl="icons" class="flex flex-row">
                    <div data-hdl="icon">img</div>
                    <div data-hdl="icon">img</div>
                  </div>
                  <div ata-hdl="replies">10 replies</div>
                  <div ata-hdl="last-reply">last reply today</div>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
      <div class="p-3 outline outline-1">
        <ul data-hdl="thread">
          <li :for={m <- @posts}>
            <div data-hdl="post" class="flex flex-row">
              <div data-hdl="left" class="basis-1/6">
                <div data-hdl="icon" class="border-2 rounded mt-3 p-3">img</div>
              </div>
              <div data-hdl="right" class="basis-5/6 border-2 rounded m-3 p-3">
                <div data-hdl="top" class="flex flex-row">
                  <div data-hdl="username">
                    <%= m.username %>
                  </div>
                  <div data-hdl="time">
                    <%= m.created_at %>
                  </div>
                </div>
                <div ata-hdl="body" class="border-t-2 mt-3 pt-3">
                  <%= m.body %>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    """
  end
end
