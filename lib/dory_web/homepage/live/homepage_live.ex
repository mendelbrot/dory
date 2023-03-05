defmodule DoryWeb.HomepageLive do
  use DoryWeb, :surface_live_view
  import Tails, warn: false

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        new_forum: false,
        username: socket.assigns.current_user.profile.username,
        forums: []
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2">
      {@username} - Home
    </h1>
    <UI.Button on_click="new-forum-true">
      +
    </UI.Button>
    {#if @new_forum}
      <div class="border-y-2">
        <Homepage.NewForum id="new-forum" user={@current_user} />
      </div>
    {/if}

    <div class="grid grid-cols-4 gap-4">
      {#for forum <- @forums}
        <button
          phx-click="goto-forum"
          phx-value-forum={forum.id}
          class="rounded-xl hover:outline hover:outline-4 hover: outline-orange-400"
        >
          forum.name
        </button>
      {/for}
    </div>
    """
  end

  def handle_event("new-forum-true", _value, socket) do
    socket = assign(socket, new_forum: true)
    {:noreply, socket}
  end

  def handle_event("new-forum-false", _value, socket) do
    socket = assign(socket, new_forum: false)
    {:noreply, socket}
  end
end
