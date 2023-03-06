defmodule DoryWeb.HomepageLive do
  use DoryWeb, :surface_live_view
  import Tails, warn: false
  alias Surface.Components.Link

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        new_forum: false,
        username: socket.assigns.current_user.profile.username,
        forums: Dory.Forums.get_my(socket.assigns.current_user.id)
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2">
      {@username} - Home
    </h1>
    <UI.Button on_click="new-true">
      +
    </UI.Button>
    {#if @new_forum}
      <div class="border-y-2 my-3 py-3">
        <Homepage.NewForum id="new-forum" user={@current_user} />
      </div>
    {/if}

    <div>
      {#for forum <- @forums}
        <div class="border-2 rounded-xl my-3 w-fit hover:bg-slate-300">
          <Link to={~p"/forum/#{forum.id}"} class="text-cyan-700 text-lg p-3">{forum.name}</Link>
        </div>
      {/for}
    </div>
    """
  end

  def handle_event("new-true", _value, socket) do
    socket = assign(socket, new_forum: true)
    {:noreply, socket}
  end

  def handle_event("new-false", _value, socket) do
    socket = assign(socket, new_forum: false)
    {:noreply, socket}
  end
end
