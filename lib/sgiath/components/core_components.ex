defmodule Sgiath.CoreComponents do
  use Phoenix.Component

  @doc """
  External link
  """
  attr :rest, :global, include: ~w(disabled form name value href)

  slot :inner_block, required: true

  def external_link(assigns) do
    ~H"""
    <a target="_blank" rel="noopener noreferrer" class="underline" {@rest}><%= render_slot(@inner_block) %></a>
    """
  end
end
