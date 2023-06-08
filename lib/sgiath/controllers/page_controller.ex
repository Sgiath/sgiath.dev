defmodule Sgiath.PageController do
  use Sgiath, :controller

  def index(conn, _params) do
    influencers = [
      {"Eliezer Yudkowsky", "https://twitter.com/ESYudkowsky"},
      {"Jordan B Peterson", "https://www.youtube.com/channel/UCL_f53ZEJxp8TtlOkHwMV9Q"},
      {"Jocko Willing", "https://www.youtube.com/channel/UCkqcY4CAuBFNFho6JgygCnA"},
      {"Michael Malice", "https://twitter.com/michaelmalice"},
      {"Smuggler", "https://www.youtube.com/channel/UCt-FpIueu3zuXjtOTYDo3Rw"},
      {"Olga Ukolova", "https://twitter.com/dr_ukolova"}
    ]

    contacts = [
      {"Web", "sgiath.dev", "https://sgiath.dev"},
      # {"Tor", Phoenix.HTML.raw("uckdsard[&hellip;]nyd.onion"),
      #  "http://uckdsardwfzfg3v5apl3lnm5p5irllqiwvia4olanhnbn5eselrftnyd.onion/"},
      {"Email", "sgiath@sgiath.dev", "mailto:sgiath@sgiath.dev"}
    ]

    social = [
      {"Nostr",
       Phoenix.HTML.raw("npub1qqqqq2z444usdf6k306djuwcyptfjj4x0teu7qzg4qj5zkkfqeeq3hlwh5"),
       "nostr:npub1qqqqq2z444usdf6k306djuwcyptfjj4x0teu7qzg4qj5zkkfqeeq3hlwh5"},
      {"Twitter", "@SgiathDev", "https://twitter.com/SgiathDev"},
      {"XMPP", "sgiath@sgiath.dev", "xmpp:sgiath@sgiath.dev"},
      {"Keybase", "sgiath", "https://keybase.io/sgiath"}
    ]

    render(conn, "index.html",
      page_title: "home",
      influencers: influencers,
      contacts: contacts,
      social: social
    )
  end

  def now(conn, _params) do
    render(conn, "now.html", page_title: "now")
  end

  def uses(conn, _params) do
    render(conn, "uses.html", page_title: "uses")
  end

  def libraries(conn, _params) do
    render(conn, "libraries.html", page_title: "libraries")
  end

  def atak(conn, _params) do
    render(conn, "atak.html", page_title: "ATAK")
  end
end
