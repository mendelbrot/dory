defmodule Homepage.NewForum do
  use Surface.LiveComponent
  alias Surface.Components.Form.TextInput
  import Tails

  prop user, :map, required: true

  data input_name, :string
  data name_state, :atom

  def mount(socket) do
    socket =
      assign(socket,
        input_name: "",
        name_state: :not_entered
      )

    {:ok, socket}
  end

  def render(assigns) do
    can_create = assigns.name_state == :available

    ~F"""
    <div>
      <div class="flex flex-row justify-between">
        <h2 class="text-green-700 text-xl font-bold mb-1 pb-1">
          New Forum
        </h2>
        <button phx-click="new-false" class="text-l font-bold border-stone-900 border-2 rounded-md px-2">
          x
        </button>
      </div>
      <TextInput
        value={@input_name}
        keyup="name-keyup"
        class={classes(
          "bg-green-100 ": @name_state == :available,
          "bg-red-100 ": @name_state == :taken,
          "w-96 rounded-xl": true
        )}
      />
      <div class="flex flex-row">
        <UI.Button on_click="new-create" target={@myself} disabled={!can_create} class="mt-3 mr-3">
          Create
        </UI.Button>
        <UI.Button on_click="new-false" class="mt-3">
          Cancel
        </UI.Button>
      </div>
    </div>
    """
  end

  # <button :on-click="new-create" phx-target={@myself} disabled={!can_create} class="mt-3 mr-3">
  #         Create
  #       </button>

  def handle_event("name-keyup", %{"value" => v} = _value, socket) do
    socket = assign(socket, input_name: v)

    if v == "" or v == nil do
      socket = assign(socket, name_state: :not_entered)
      {:noreply, socket}
    else
      if Dory.Forums.get_by_name(v) do
        socket = assign(socket, name_state: :taken)
        {:noreply, socket}
      else
        socket = assign(socket, name_state: :available)
        {:noreply, socket}
      end
    end
  end

  def handle_event("new-create", _value, socket) do
    new_forum = %{
      name: socket.assigns.input_name
    }

    Dory.Forums.create(new_forum, [socket.assigns.user.id])

    socket =
      socket
      |> put_flash(:info, "Forum Created.")
      |> push_navigate(to: "/")

    {:noreply, socket}
  end
end
