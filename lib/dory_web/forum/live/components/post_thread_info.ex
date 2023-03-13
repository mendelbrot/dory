defmodule Forum.PostThreadInfo do
  use Surface.Component

  prop num_replies, :string, required: true
  prop last_reply, :string, required: true

  def render(assigns) do
    ~F"""
    <div data-hdl="bottom" class="border-t-2 pt-3 border-blue-400">
      <div data-hdl="replies">{@num_replies} replies.  last reply at:</div>
      <div data-hdl="last-reply">{@last_reply}</div>
    </div>
    """
  end
end
