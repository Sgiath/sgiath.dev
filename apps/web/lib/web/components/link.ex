defmodule Web.Components.Link do
  use Phoenix.Component

  def external(assigns) do
    ~H"""
    <a target="_blank" rel="noopener noreferrer" href={@to}><%= @text %></a>
    """
  end
end
