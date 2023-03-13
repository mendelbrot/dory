defmodule DoryWeb.ForumLive do
  use DoryWeb, :surface_live_view
  alias Surface.Components.Form.TextArea

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
        ref_id: "123",
        post_to_main_feed: true,
        body: "hello 👋 this is a post 😃",
        replies: [
          %{
            id: "545",
            user_id: "1",
            forum_id: "999",
            username: "cba",
            created_at: "2023-08-12 21:06:17+03",
            updated_at: "2023-08-12 21:06:17+03",
            ref_id: "123",
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
            ref_id: "123",
            post_to_main_feed: false,
            body: "hi there.  this is neat. 💚"
          }
        ]
      },
      %{
        id: "545",
        user_id: "1",
        forum_id: "999",
        username: "cba",
        created_at: "2023-08-12 21:06:17+03",
        updated_at: "2023-08-12 21:06:17+03",
        ref_id: "123",
        post_to_main_feed: true,
        body: "🌠🚀 and 👾",
        replies: []
      }
    ]

    main_feed =
      posts
      |> Enum.filter(fn p -> p.post_to_main_feed == true end)
      |> Enum.sort(fn p1, p2 -> p1.created_at <= p2.created_at end)

    selected_post_id = nil

    selected_post_thread = nil

    socket =
      assign(socket,
        main_feed: main_feed,
        forum_name: forum_name,
        selected_post_id: selected_post_id,
        selected_post_thread: selected_post_thread
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <UI.H1>{@forum_name}</UI.H1>
    <div class="flex flex-row border-l-2 border-blue-400">
      <Forum.Thread id="forum-main-feed" posts={@main_feed} heading="Main Feed" />
      {#if @selected_post_id}
        <Forum.Thread
          id="forum-thread"
          selected_post_id={@selected_post_id}
          posts={@selected_post_thread}
          heading="Thread"
        >
          <button
            phx-click="clear-selected-post"
            class="text-l font-bold border-stone-900 border-2 rounded-md px-2"
          >
            x
          </button>
        </Forum.Thread>
      {/if}
    </div>
    """
  end

  def handle_event("select-post", value, %{assigns: %{main_feed: m}} = socket) do
    selected_post_id = value["id"]
    selected_post_ref_id = value["ref-id"]

    IO.inspect(m)

    # the first post of the thread is found by the ref_id of the selected post
    thread_start_post = Enum.find(m, fn p -> p.id == selected_post_ref_id end)

    # the replies are in a nested subfield of the first post.   they need to be appended to the thread instead.
    # so after processing, the thread looks like this: [first post minus replies | first post replies].
    selected_post_thread =
      case thread_start_post.replies do
        [_ | _] -> [Map.drop(thread_start_post, [:replies]) | thread_start_post.replies]
        _ -> [thread_start_post]
      end

    socket =
      assign(socket,
        selected_post_id: selected_post_id,
        selected_post_thread: selected_post_thread
      )

    {:noreply, socket}
  end

  def handle_event("clear-selected-post", _value, socket) do
    socket = assign(socket, selected_post_id: nil, selected_post_thread: nil)
    {:noreply, socket}
  end
end
