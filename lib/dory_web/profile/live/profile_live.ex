defmodule DoryWeb.ProfileLive do
  use DoryWeb, :surface_live_view

  def mount(_params, _session, socket) do
    profile_icons = [
      "https://cdn-icons-png.flaticon.com/128/3069/3069186.png",
      "https://cdn-icons-png.flaticon.com/128/2977/2977402.png",
      "https://cdn-icons-png.flaticon.com/128/3196/3196017.png",
      "https://cdn-icons-png.flaticon.com/128/809/809052.png",
      "https://cdn-icons-png.flaticon.com/128/2632/2632839.png",
      "https://cdn-icons-png.flaticon.com/128/3975/3975047.png",
      "https://cdn-icons-png.flaticon.com/128/1864/1864521.png",
      "https://cdn-icons-png.flaticon.com/128/2739/2739481.png",
      "https://cdn-icons-png.flaticon.com/128/4356/4356381.png",
      "https://cdn-icons-png.flaticon.com/128/3788/3788675.png",
      "https://cdn-icons-png.flaticon.com/128/2524/2524620.png",
      "https://cdn-icons-png.flaticon.com/128/5449/5449557.png"
    ]

    socket =
      assign(socket,
        profile_icons: profile_icons
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2 outline-2">
      Profile
    </h1>
    <div class="grid grid-cols-4 gap-4">
      {#for icon <- @profile_icons}
        <Profile.Icon src={icon} />
      {/for}
    </div>
    """
  end
end
