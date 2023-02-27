defmodule Profile.Icon do
  use Surface.Component

  prop src, :string, required: true

  def render(assigns) do
    ~F"""
    <div class="bg-yellow-100 w-16 border-2 border-blue-500 rounded-xl p-2">
      <img src={@src} alt="profile icon">
    </div>
    """
  end
end
