# auto-generated

/ip dns static remove [find where comment="github:gpt"]
/ip dns static add name=anthropic.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=auth0.openai.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=chatgpt.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=claude.ai type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=google-analytics.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=googleusercontent.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=lh3.googleusercontent.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=oaistatic.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=oaiusercontent.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=openai.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=perplexity.ai type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
/ip dns static add name=poe.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"

/ip dns static remove [find where comment="github:youtube"]
/ip dns static add name=disneyplus.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=dssott.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=ggpht.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=googleusercontent.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=googlevideo.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=gvt1.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=gvt2.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=music.apple.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=mzstatic.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=netflix.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=nflximg.net type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=nflxso.net type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=nflxvideo.net type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=scdn.co type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=soundcloud.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=spotify.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=spotifycdn.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=ttvnw.net type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=twitch.tv type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=youtu.be type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=youtube-nocookie.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=youtube.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
/ip dns static add name=ytimg.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"

/ip dns static remove [find where comment="github:telegram"]
/ip dns static add name=t.me type=FWD match-subdomain=yes address-list=to-mihomo-telegram comment="github:telegram"
/ip dns static add name=tdesktop.com type=FWD match-subdomain=yes address-list=to-mihomo-telegram comment="github:telegram"
/ip dns static add name=telegra.ph type=FWD match-subdomain=yes address-list=to-mihomo-telegram comment="github:telegram"
/ip dns static add name=telegram.org type=FWD match-subdomain=yes address-list=to-mihomo-telegram comment="github:telegram"

/ip dns static remove [find where comment="github:whatsapp"]
/ip dns static add name=whatsapp.com type=FWD match-subdomain=yes address-list=to-mihomo-whatsapp comment="github:whatsapp"
/ip dns static add name=whatsapp.net type=FWD match-subdomain=yes address-list=to-mihomo-whatsapp comment="github:whatsapp"

/ip dns static remove [find where comment="github:gpt-regex"]
/ip dns static remove [find where comment="github:youtube-regex"]
/ip dns static add regexp="(^|.*\\.)googlevideo\\.com$" type=FWD address-list=to-mihomo-youtube comment="github:youtube-regex"
/ip dns static add regexp="(^|.*\\.)oaistatic\\.com$" type=FWD address-list=to-mihomo-gpt comment="github:gpt-regex"

