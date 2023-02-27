defmodule UI.Button do
  use Surface.Component

  prop disabled, :boolean, default: false
  # <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
  # <button class="bg-blue-500 text-white font-bold py-2 px-4 rounded opacity-50 cursor-not-allowed">
  # disabled={@disabled}

  slot default

  def render(assigns) do
    ~F"""
    <button
      disabled={@disabled}
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
    >
      <#slot>{""}</#slot>
    </button>
    """
  end
end
