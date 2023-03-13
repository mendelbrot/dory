defmodule DoryWeb.ForumLive do
  use DoryWeb, :surface_live_view

  def mount(params, _session, socket) do
    forum_id = params["forum_id"]

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
    thread_uri = nil
    selected_thread = nil

    # these are messages in progress: text that was entered into a textarea but not yet sent.
    # they are saved in a map so that if the user leaves a thread and comes back they will not loose their text.
    # (as long as they don't navigate away from forum the page)
    message_input_values = %{}

    socket =
      assign(socket,
        main_feed: main_feed,
        forum_name: forum_name,
        forum_id: forum_id,
        selected_post_id: selected_post_id,
        selected_thread: selected_thread,
        thread_uri: thread_uri,
        message_input_values: message_input_values
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <UI.H1>{@forum_name}</UI.H1>
    <div class="flex flex-row border-l-2 border-blue-400">
      <Forum.Thread
        heading="Main Feed"
        thread_uri={"forum/#{@forum_id}"}
        posts={@main_feed}
        message_input_value={Map.get(@message_input_values, "forum/#{@forum_id}")}
      />
      {#if @selected_post_id}
        <Forum.Thread
          heading="Thread"
          thread_uri={@thread_uri}
          selected_post_id={@selected_post_id}
          posts={@selected_thread}
          message_input_value={Map.get(@message_input_values, @thread_uri)}
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

  def handle_event(
        "select-post",
        %{"id" => id, "ref-id" => ref_id} = _value,
        %{assigns: %{forum_id: forum_id, main_feed: main_feed}} = socket
      ) do
    # the first post of the thread is found by the ref_id of the selected post
    thread_start_post = Enum.find(main_feed, fn p -> p.id == ref_id end)

    # the replies are in a nested subfield of the first post.   they need to be appended to the thread instead.
    # so after processing, the thread looks like this: [first post minus replies | first post replies].
    selected_thread =
      case Map.has_key?(thread_start_post, :replies) && thread_start_post.replies do
        [_ | _] -> [Map.delete(thread_start_post, :replies) | thread_start_post.replies]
        _ -> [thread_start_post]
      end

    socket =
      assign(socket,
        selected_post_id: id,
        thread_uri: "forum/#{forum_id}/thread/#{ref_id}",
        selected_thread: selected_thread
      )

    {:noreply, socket}
  end

  def handle_event("clear-selected-post", _value, socket) do
    socket =
      assign(socket,
        selected_post_id: nil,
        thread_uri: nil,
        selected_thread: nil
      )

    {:noreply, socket}
  end

  def handle_event(
        "message-input-keyup",
        %{"id" => id, "value" => value} = _value,
        %{assigns: %{message_input_values: mivs}} = socket
      ) do
    socket =
      assign(socket,
        message_input_values: Map.put(mivs, id, value)
      )

    {:noreply, socket}
  end

  def handle_event(
        "send-post",
        %{"value" => thread_uri} = _value,
        %{assigns: %{message_input_values: mivs}} = socket
      ) do
    body = Map.get(mivs, thread_uri)

    # TODO: create the post
    IO.inspect(thread_uri)
    IO.inspect(body)

    socket =
      assign(socket,
        message_input_values: Map.delete(mivs, thread_uri)
      )

    {:noreply, socket}
  end
end
