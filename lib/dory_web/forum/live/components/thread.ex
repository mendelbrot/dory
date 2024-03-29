defmodule Forum.Thread do
  use Surface.Component
  alias Surface.Components.Form.TextArea

  prop(thread_uri, :string, required: true)
  prop(message_input_value, :string, default: "")
  prop(post_id, :string, default: nil)
  prop(posts, :list, default: [])
  prop(heading, :string, default: nil)

  slot(default)

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
              <Forum.Post post={p} highlight={p.id == @post_id}>
                {#if Map.has_key?(p, :num_replies) and Map.has_key?(p, :last_reply)}
                  <Forum.PostThreadInfo
                    num_replies={p.num_replies}
                    last_reply={p.last_reply}
                  />
                {/if}
              </Forum.Post>
            </li>
          {/for}
        </ul>
      </div>
      <div class="p-3 border-b-2 border-r-2 border-blue-400">
        <TextArea
          class="w-full rounded-lg"
          value={@message_input_value}
          opts={"phx-value-id": @thread_uri}
          keyup="message-input-keyup"
        />
        <div class="flex flex-row justify-end items-end mt-3">
          <UI.Button value={@thread_uri} on_click="send-post">></UI.Button>
        </div>
      </div>
    </div>
    """
  end
end
