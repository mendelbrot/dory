# defmodule DoryWeb.ForumLive do
#   use DoryWeb, :surface_live_view

#   def mount(_params, _session, socket) do
#     {:ok, assign(socket, name: "you")}
#   end

#   prop name, :string, required: true

#   def render(assigns) do
#     ~F"""
#     <Hello name="John Doe" />
#     """
#   end
# end

# defmodule Hello do
#   use Surface.Component

#   prop name, :string, required: true

#   def render(assigns) do
#     ~F"""
#     Hello, {@name}!
#     """
#   end
# end
