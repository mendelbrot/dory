defmodule DoryWeb.ForumLive do
  use DoryWeb, :surface_live_view

  @doc """
  helper function to parse data from the uri of a forum, post or thread.

  this is used in the "send-post" event handler because the uri passed into the
  thread_uri prop of <Forum.Thread/> uniquely identifies the the target of the
  text input data for a new post: if it will be starting a new thread, or a
  reply to an existing thread_id.
  """
  def parse(uri) do
    parts = String.split(uri, "/")

    case parts do
      ["forum", forum_id, "thread", thread_id, "post", post_id] ->
        %{forum_id: forum_id, thread_id: thread_id, post_id: post_id}

      ["forum", forum_id, "thread", thread_id] ->
        %{forum_id: forum_id, thread_id: thread_id}

      ["forum", forum_id] ->
        %{forum_id: forum_id}
    end
  end

  @doc """
  Initializes the messages in progress

  messages in progress (message_input_values):
  - text that was entered into a textarea but not yet sent.
  - they are saved in a map so that if the user leaves a thread and comes back they will not loose their text. (as long as they don't navigate away from forum the page)
  """
  def mount(_params, _session, socket) do
    message_input_values = %{}

    socket =
      assign(socket,
        message_input_values: message_input_values
      )

    {:ok, socket}
  end

  @doc """
  1. read the forum id, thread id and post id from the uri
  2. get the forum name
  3. get the forum main feed
  4. put the forum data in the socket
  5. if a selected thread is also in the uri, also put the thread data in the socket
  6. if a selected post is also in the uri, also put the post data in the socket (the selected post will be highlighted.  a selected post requires a selected thread.)
  """
  def handle_params(
        params,
        _uri,
        socket
      ) do
    forum_id = Map.get(params, "forum_id")
    thread_id = Map.get(params, "thread_id")
    post_id = Map.get(params, "post_id")

    %{name: forum_name} = Dory.Forums.get(forum_id)

    threads = Dory.Feeds.forum_live_view_data(forum_id)

    main_feed =
      threads
      |> Enum.filter(fn thread ->
        posts = Map.get(thread, :posts_vm)
        not Enum.empty?(posts)
      end)
      |> Enum.map(fn thread ->
        posts = Map.get(thread, :posts_vm)
        Enum.at(posts, 0)
      end)

    thread =
      case thread_id do
        nil ->
          nil

        _ ->
          threads
          |> Enum.find(fn t -> t.id == thread_id end)
          |> Map.get(:posts_vm)
      end

    socket =
      assign(socket,
        forum_name: forum_name,
        forum_id: forum_id,
        forum_uri: "forum/#{forum_id}",
        thread_id: thread_id,
        thread_uri: thread_id && "forum/#{forum_id}/thread/#{thread_id}",
        post_id: post_id,
        post_uri: thread_id && post_id && "forum/#{forum_id}/thread/#{thread_id}/post/#{post_id}",
        main_feed: main_feed,
        thread: thread
      )

    {:noreply, socket}
  end

  def render(assigns) do
    ~F"""
    <UI.H1>{@forum_name}</UI.H1>
    <div class="flex flex-row border-l-2 border-blue-400">
      <Forum.Thread
        heading="Main Feed"
        thread_uri={@forum_uri}
        posts={@main_feed}
        message_input_value={Map.get(@message_input_values, @forum_uri)}
      />
      {#if @thread_id}
        <Forum.Thread
          heading="Thread"
          thread_uri={@thread_uri}
          post_id={@post_id}
          posts={@thread}
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
        %{"id" => post_id, "thread-id" => thread_id} = _value,
        %{assigns: %{forum_id: forum_id}} = socket
      ) do
    thread_uri = "/forum/#{forum_id}/thread/#{thread_id}/post/#{post_id}"

    socket = push_patch(socket, to: thread_uri)

    {:noreply, socket}
  end

  def handle_event("clear-selected-post", _value, %{assigns: %{forum_id: forum_id}} = socket) do
    uri = "/forum/#{forum_id}"

    socket = push_patch(socket, to: uri)

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
        %{
          assigns: %{
            message_input_values: mivs,
            current_user: %{id: user_id}
          }
        } = socket
      ) do
    body = Map.get(mivs, thread_uri)

    uri_data = parse(thread_uri)
    forum_id = Map.get(uri_data, :forum_id)
    thread_id = Map.get(uri_data, :thread_id)

    post_to_main_feed = thread_id == nil

    thread =
      thread_id &&
        Enum.find(
          socket.assigns.main_feed,
          fn t -> t.id == thread_id end
        )

    posts = thread && Map.get(thread, :posts)
    ref_id = posts && !Enum.empty?(posts) && Map.get(Enum.at(posts, 0), "id")

    new_post =
      Map.filter(
        %{
          user_id: user_id,
          forum_id: forum_id,
          thread_id: thread_id,
          ref_id: ref_id,
          post_to_main_feed: post_to_main_feed,
          body: body
        },
        fn {_, v} -> v != nil end
      )

    Dory.Posts.create(new_post)

    socket =
      assign(socket,
        message_input_values: Map.delete(mivs, thread_uri)
      )

    {:noreply, socket}
  end
end
