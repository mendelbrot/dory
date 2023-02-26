defmodule Thread do
  use Surface.Component

  prop selected_post, :map, required: true

  def render(assigns) do
    # get the posts in the thread

    posts = [
      %{
        id: "123",
        user_id: "234",
        forum_id: "999",
        username: "abc",
        user_icon: "/images/user_icons/123.png",
        created_at: "2022-08-11 21:06:17+03",
        updated_at: "2022-08-11 21:06:17+03",
        ref_post_id: nil,
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

    assigns = assign(assigns, posts: posts)

    # prop posts, :list, default: nil

    ~F"""
    <div>
      <div class="p-3 outline outline-1">
        <div data-hdl="thread-header" class="flex flex-row justify-between">
          <h2 class="text-blue-500 text-xl font-bold">Thread</h2>
          <button
            phx-click="clear-selected-post"
            class="text-l font-bold border-stone-900 border-2 rounded-md px-2"
          >
            x
          </button>
        </div>
      </div>
      <div class="p-3 outline outline-1">
        <ul data-hdl="thread">
          {#for p <- @posts}
            <li>
              <ThreadPost post={p} highlight={p.id == @selected_post["id"]} />
            </li>
          {/for}
        </ul>
      </div>
    </div>
    """
  end
end
