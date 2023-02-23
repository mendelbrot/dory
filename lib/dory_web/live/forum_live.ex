defmodule DoryWeb.ForumLive do
  use DoryWeb, :live_view

  def mount(_params, _session, socket) do
    messages = [
      %{
        id: "123",
        user_id: "234",
        username: "abc",
        created_at: "2022-08-11 21:06:17+03",
        updated_at: "2022-08-11 21:06:17+03",
        ref_message_id: nil,
        body: "hello 👋 this is a message 😃"
      },
      %{
        id: "543",
        user_id: "1",
        username: "cba",
        created_at: "2023-08-11 21:06:17+03",
        updated_at: "2023-08-11 21:06:17+03",
        ref_message_id: "123",
        body: "hi there.  this is neat. 💚"
      }
    ]

    socket = assign(socket, messages: messages)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Forum 123</h1>
    <div>
      <ul>
        <li :for={m <- @messages}>
          <%= m.body %>
        </li>
      </ul>
    </div>
    """
  end
end
