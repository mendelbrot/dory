defmodule DoryWeb.ForumLive do
  use DoryWeb, :surface_live_view

  def mount(params, _session, socket) do
    _forum_id = params["forum_id"]

    # get forum name
    # get list of forum posts

    forum_name = "Home"

    posts = [
      %{
        id: "123",
        user_id: "234",
        forum_id: "999",
        username: "abc",
        user_icon: "/images/user_icons/123.png",
        created_at: "2022-08-11 21:06:17+03",
        updated_at: "2022-08-11 21:06:17+03",
        ref_post_id: "123",
        post_to_main_feed: true,
        body: "hello 👋 this is a post 😃"
      },
      %{
        id: "545",
        user_id: "1",
        forum_id: "999",
        username: "cba",
        created_at: "2023-08-12 21:06:17+03",
        updated_at: "2023-08-12 21:06:17+03",
        ref_post_id: "123",
        post_to_main_feed: true,
        body: "🌠🚀 and 👾"
      },
      %{
        id: "543",
        user_id: "1",
        forum_id: "999",
        username: "cba",
        created_at: "2023-08-11 21:06:17+03",
        updated_at: "2023-08-11 21:06:17+03",
        ref_post_id: "123",
        post_to_main_feed: false,
        body: "hi there.  this is neat. 💚"
      }
    ]

    main_feed =
      posts
      |> Enum.filter(fn p -> p.post_to_main_feed == true end)
      |> Enum.sort(fn p1, p2 -> p1.created_at <= p2.created_at end)

    selected_post = nil

    socket =
      assign(socket,
        main_feed: main_feed,
        forum_name: forum_name,
        selected_post: selected_post
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2 outline-2">
      {@forum_name}
    </h1>
    <div class="flex flex-row">
      <div>
        <div class="p-3 outline outline-1">
          <div data-hdl="posts-header">
            <h2 class="text-green-500 text-xl font-bold">Posts</h2>
          </div>
        </div>
        <div class="p-3 outline outline-1">
          <ul data-hdl="posts">
            {#for p <- @main_feed}
              <li>
                <Forum.Post post={p} />
              </li>
            {/for}
          </ul>
        </div>
      </div>
      {#if @selected_post}
        <Forum.Thread id="forum-thread" selected_post={@selected_post} />
      {/if}
    </div>
    """
  end

  def handle_event("select-post", value, socket) do
    socket = assign(socket, selected_post: value)
    {:noreply, socket}
  end

  def handle_event("clear-selected-post", _value, socket) do
    socket = assign(socket, selected_post: nil)
    {:noreply, socket}
  end
end
