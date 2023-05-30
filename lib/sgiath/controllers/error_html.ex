defmodule Sgiath.ErrorHTML do
  @moduledoc false
  use Sgiath, :html

  # If you want to customize your error pages,
  # uncomment the embed_templates/1 call below
  # and add pages to the error directory:
  #
  #   * lib/web/controllers/error/404.html.heex
  #   * lib/web/controllers/error/500.html.heex
  #
  # embed_templates "error/*"

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
