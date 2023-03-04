defmodule DoryWeb.HomepageLive do
  use DoryWeb, :surface_live_view
  import Tails, warn: false

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <h1 class="text-blue-500 text-2xl font-bold mb-3 pb-3 border-b-2">
      Hompage
    </h1>
    """
  end
end
