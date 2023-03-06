defmodule Forum.PostThreadInfo do
  use Surface.Component

  def render(assigns) do
    ~F"""
    <div data-hdl="bottom" class="border-t-2 pt-3 border-blue-400 flex flex-row">
      <div data-hdl="icons" class="flex flex-row">
        <div data-hdl="icon">img</div>
        <div data-hdl="icon">img</div>
      </div>
      <div data-hdl="replies">10 replies</div>
      <div data-hdl="last-reply">last reply today</div>
    </div>
    """
  end
end
