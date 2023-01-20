defmodule Web.PageController do
  use Web, :controller

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
      {"Nostr", Phoenix.HTML.raw("00000[&hellip;]90672"),
       "https://astral.ninja/0000002855ad7906a7568bf4d971d82056994aa67af3cf0048a825415ac90672"},
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

  def nostr(conn, _params) do
    render(conn, "nostr.html", page_title: "nostr")
  end
end
