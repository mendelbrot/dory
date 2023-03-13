defmodule Forum.Thread do
  use Surface.LiveComponent
  alias Surface.Components.Form.TextArea

  prop selected_post_id, :string, default: nil
  prop posts, :list, default: []
  prop heading, :string, default: nil

  slot default

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div class="bg-white border-r-2 border-blue-400 w-1/2">
      <div class="p-3 border-y-2 border-blue-400">
        <div data-hdl="thread-header" class="flex flex-row justify-between">
          <UI.H2>{@heading}</UI.H2>
          <#slot />
        </div>
      </div>
      <div class="p-3 border-b-2 border-blue-400 h-96 overflow-scroll">
        <ul data-hdl="thread">
          {#for p <- @posts}
            <li>
              <Forum.Post post={p} highlight={p.id == @selected_post_id}>
                {#if Map.has_key?(p, :replies) && !Enum.empty?(p.replies)}
                  <Forum.PostThreadInfo
                    num_replies={length(p.replies)}
                    last_reply={List.last(p.replies).created_at}
                  />
                {/if}
              </Forum.Post>
            </li>
          {/for}
        </ul>
      </div>
      <div class="p-3 border-b-2 border-r-2 border-blue-400">
        <TextArea class="w-full" />
        <div class="flex flex-row justify-end items-end mt-3">
          <UI.Button>></UI.Button>
        </div>
      </div>
    </div>
    """
  end
end
