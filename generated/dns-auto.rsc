# auto-generated
/ip dns static

/ip dns static remove [find where comment="github:gpt"]
add name=chatgpt.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
add name=oaistatic.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
add name=oaiusercontent.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
add name=openai.com type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"
add name=sendgrid.net type=FWD match-subdomain=yes address-list=to-mihomo-gpt comment="github:gpt"

/ip dns static remove [find where comment="github:youtube"]
add name=ggpht.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
add name=googlevideo.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
add name=youtu.be type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
add name=youtube-nocookie.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
add name=youtube.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"
add name=ytimg.com type=FWD match-subdomain=yes address-list=to-mihomo-youtube comment="github:youtube"

/ip dns static remove [find where comment="github:telegram"]

/ip dns static remove [find where comment="github:whatsapp"]

