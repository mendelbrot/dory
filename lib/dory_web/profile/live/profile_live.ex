defmodule DoryWeb.ProfileLive do
  use DoryWeb, :surface_live_view
  alias Surface.Components.Form.TextInput
  import Tails

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

    selected_icon = nil

    username_state = :not_chosen

    socket =
      assign(socket,
        profile_icons: profile_icons,
        selected_icon: selected_icon,
        username_state: username_state
      )

    {:ok, socket}
  end

  def render(assigns) do
    can_submit = assigns.selected_icon && assigns.username_state == :available && true

    ~F"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2">
      Profile
    </h1>
    <h2 class="text-green-500 text-xl font-bold mb-1 pb-1">
      Username
    </h2>

    <TextInput
      value="hello!!!"
      keyup="username-keyup"
      class={classes(
        "bg-green-200 ": @username_state == :available,
        "bg-red-200 ": @username_state == :taken,
        "w-96 rounded-xl": true
      )}
    />
    <h2 class="text-green-500 text-xl font-bold mb-1 pb-1" , "text-yellow-500">
      Profile Icon
    </h2>
    <div />
    <div>{@selected_icon}</div>
    <div class="grid grid-cols-4 gap-4">
      {#for icon <- @profile_icons}
        <button
          phx-click="select-icon"
          phx-value-icon={icon}
          class={classes(
            "outline outline-4 outline-blue-500": icon == @selected_icon,
            "hover:outline hover:outline-4 hover: outline-orange-400": icon != @selected_icon,
            " w-16 rounded-xl": true
          )}
        >
          <Profile.Icon src={icon} />
        </button>
      {/for}
    </div>
    <UI.Button
      on_click="save"
      disabled={!can_submit}
      class="bg-fuchsia-400 hover:bg-fuchsia-600 my-3"
    >
      Save
    </UI.Button>
    """
  end

  def handle_event("select-icon", value, socket) do
    socket = assign(socket, selected_icon: value["icon"])
    {:noreply, socket}
  end

  def handle_event("username-keyup", value, socket) do
    if value["value"] === "hi" do
      socket = assign(socket, username_state: :taken)
      {:noreply, socket}
    else
      socket = assign(socket, username_state: :available)
      {:noreply, socket}
    end
  end

  def handle_event("save", _value, socket) do
    {:noreply, socket}
  end
end
