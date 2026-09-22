# MikroTik VPN domain lists

This repository builds domain-based RouterOS address lists used to route selected
services through Mihomo.

## Groups

- `ai`: OpenAI, ChatGPT, Anthropic and Perplexity
- `instagram`: Instagram
- `telegram`: Telegram and selected TON services
- `whatsapp`: WhatsApp
- `youtube`: YouTube only
- `sites`: manually selected sites such as GitHub, Docker and Signal

Local additions live in `domains/`. Selected upstream lists are downloaded from
[`v2fly/domain-list-community`](https://github.com/v2fly/domain-list-community)
and stored in `upstream/` so every update can be reviewed.

## Automation

GitHub Actions runs every Monday at 03:17 UTC and on relevant pushes. It:

1. downloads selected upstream lists;
2. resolves their includes;
3. validates and deduplicates entries;
4. rejects private or overly broad IPv4 networks;
5. runs unit tests;
6. commits changed upstream snapshots and `generated/dns-auto.rsc`.

Run locally:

```bash
python scripts/generate_dns.py --update-upstream
python -m unittest discover -s tests -v
```

Install `routeros/install-lists-updater.rsc` once on RouterOS. The router then
checks the generated artifact daily and imports it only after basic size and TLS
certificate checks.
