defmodule DoryWeb.ProfileLive do
  use DoryWeb, :surface_live_view
  alias Surface.Components.Form.TextInput
  import Tails
  alias Dory.Accounts

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

    %{current_user: user} = socket.assigns
    profile = user && user.profile

    socket =
      assign(socket,
        profile_icons: profile_icons,
        profile: profile,
        username: profile && profile.username,
        icon: profile && profile.icon,
        input_username: profile && profile.username,
        username_state: :not_entered,
        input_icon: profile && profile.icon
      )

    {:ok, socket}
  end

  def render(assigns) do
    can_submit =
      assigns.input_icon &&
        assigns.input_username != "" &&
        assigns.username_state != :taken

    ~F"""
    <UI.H1>{if @profile, do: "Edit", else: "Create"} Profile</UI.H1>
    <UI.H2 class="my-3">Username</UI.H2>

    <TextInput
      value={@input_username}
      keyup="username-keyup"
      class={classes(
        "bg-green-100 ": @username_state == :available,
        "bg-red-100 ": @username_state == :taken,
        "w-96 rounded-xl": true
      )}
    />
    <UI.H2 class="my-3">Profile Icon</UI.H2>
    <div />
    <div class="flex flex-row mb-6">
      <Profile.Icon src={@input_icon} />
    </div>
    <UI.H2 class="my-3">Select Icon</UI.H2>
    <div class="grid grid-cols-4 gap-4">
      {#for icon <- @profile_icons}
        <button
          phx-click="select-icon"
          phx-value-icon={icon}
          class={classes(
            "outline outline-4 outline-blue-500": icon == @input_icon,
            "hover:outline hover:outline-4 hover: outline-orange-400": icon != @input_icon,
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

  # - puts the input icon in the socket
  def handle_event("select-icon", value, socket) do
    socket = assign(socket, input_icon: value["icon"])
    {:noreply, socket}
  end

  # - puts the input value in the socket
  # - checks some conditions to set username_state
  def handle_event("username-keyup", %{"value" => v} = _value, socket) do
    socket = assign(socket, input_username: v)

    if v == socket.assigns.username or v == "" or v == nil do
      socket = assign(socket, username_state: :not_entered)
      {:noreply, socket}
    else
      if Accounts.profile_by_username(v) do
        socket = assign(socket, username_state: :taken)
        {:noreply, socket}
      else
        socket = assign(socket, username_state: :available)
        {:noreply, socket}
      end
    end
  end

  # - either creates or updates the profile depending on of the profile already exists
  # - displays a success flash
  # - redirects to the homepage
  def handle_event("save", _value, socket) do
    new_profile = %{
      user_id: socket.assigns.current_user.id,
      username: socket.assigns.input_username,
      icon: socket.assigns.input_icon
    }

    if socket.assigns.profile do
      Accounts.update_profile(socket.assigns.profile, new_profile)
    else
      Accounts.create_profile(new_profile)
    end

    socket =
      socket
      |> put_flash(:info, "Profile saved.")
      |> push_navigate(to: ~p"/")

    {:noreply, socket}
  end
end
