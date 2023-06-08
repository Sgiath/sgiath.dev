defmodule Sgiath.CoreComponents do
  use Phoenix.Component

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button phx-click="go" class="ml-2">Send!</.button>
  """
  attr :type, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button
      type={@type}
      class={[
        "phx-submit-loading:opacity-75 rounded-lg bg-zinc-700 hover:bg-zinc-500 mt-2 mb-2 py-2 px-3",
        "text-sm font-semibold leading-6 text-white active:text-white/80",
        @class
      ]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  @doc """
  Title
  """
  slot :inner_block, required: true

  def title(assigns) do
    ~H"""
    <h2 class="text-[1.5rem] text-zinc-100 font-semibold mb-2 mt-8"><%= render_slot(@inner_block) %></h2>
    """
  end

  @doc """
  Subtitle
  """
  attr :id, :string
  slot :inner_block, required: true

  def subtitle(assigns) do
    ~H"""
    <h3 id={@id} class="text-[1.2rem] text-zinc-100 font-semibold mb-2 mt-8"><%= render_slot(@inner_block) %></h3>
    """
  end

  @doc """
  Subsubtitle
  """
  slot :inner_block, required: true

  def subsubtitle(assigns) do
    ~H"""
    <h4 class="text-[1rem] text-zinc-100 font-semibold mb-2 mt-8"><%= render_slot(@inner_block) %></h4>
    """
  end

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

  @doc """
  Renders a header with title.
  """
  attr :class, :string, default: nil

  slot :inner_block, required: true
  slot :subtitle
  slot :actions

  def header(assigns) do
    ~H"""
    <header class={[@actions != [] && "flex items-center justify-between gap-6", @class]}>
      <div>
        <h1 class="text-lg font-semibold leading-8 text-zinc-800">
          <%= render_slot(@inner_block) %>
        </h1>
        <p :if={@subtitle != []} class="mt-2 text-sm leading-6 text-zinc-600">
          <%= render_slot(@subtitle) %>
        </p>
      </div>
      <div class="flex-none"><%= render_slot(@actions) %></div>
    </header>
    """
  end
end
