defmodule Web.PageController do
  use Web, :controller

  def index(conn, _params) do
    influencers = [
      {"Eliezer Yudkowsky", "https://twitter.com/ESYudkowsky"},
      {"Jordan B Peterson", "https://www.youtube.com/channel/UCL_f53ZEJxp8TtlOkHwMV9Q"},
      {"Jocko Willing", "https://www.youtube.com/channel/UCkqcY4CAuBFNFho6JgygCnA"},
      {"Michael Malice", "https://twitter.com/michaelmalice"},
      {"Smuggler", "https://www.youtube.com/channel/UCt-FpIueu3zuXjtOTYDo3Rw"},
      {"Olga Ukolova", "https://twitter.com/OlUkolova"}
    ]

    contacts = [
      {"Web", "sgiath.dev", "https://sgiath.dev"},
      {"Tor", Phoenix.HTML.raw("uckdsard[&hellip;]nyd.onion"),
       "http://uckdsardwfzfg3v5apl3lnm5p5irllqiwvia4olanhnbn5eselrftnyd.onion/"},
      {"Email", "sgiath@sgiath.dev", "mailto:sgiath@sgiath.dev"}
    ]

    render(conn, "index.html", page_title: "home", influencers: influencers, contacts: contacts)
  end

  def now(conn, _params) do
    render(conn, "now.html", page_title: "now")
  end

  def uses(conn, _params) do
    render(conn, "uses.html", page_title: "uses")
  end
end
