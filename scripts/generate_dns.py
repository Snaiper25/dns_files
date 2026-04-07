from pathlib import Path

BASE = Path(".")
DOMAINS_DIR = BASE / "domains"
OUT = BASE / "generated" / "dns-auto.rsc"

GROUPS = [
    ("gpt.txt", "github:gpt", "to-mihomo-gpt"),
    ("youtube.txt", "github:youtube", "to-mihomo-youtube"),
    ("telegram.txt", "github:telegram", "to-mihomo-telegram"),
    ("whatsapp.txt", "github:whatsapp", "to-mihomo-whatsapp"),
]

REGEX_FILE = DOMAINS_DIR / "regex.txt"


def read_lines(path: Path):
    if not path.exists():
        return []
    result = []
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip().lower()
        if not line or line.startswith("#"):
            continue
        result.append(line)
    return sorted(set(result))


def build_normal_group(filename, comment, address_list):
    domains = read_lines(DOMAINS_DIR / filename)
    lines = [f'/ip dns static remove [find where comment="{comment}"]']
    for d in domains:
        lines.append(
            f'add name={d} type=FWD match-subdomain=yes '
            f'address-list={address_list} comment="{comment}"'
        )
    lines.append("")
    return lines


def build_regex_group():
    lines = []
    if not REGEX_FILE.exists():
        return lines

    regex_entries = []
    for raw in REGEX_FILE.read_text(encoding="utf-8").splitlines():
        raw = raw.strip()
        if not raw or raw.startswith("#"):
            continue
        parts = raw.split("|", 2)
        if len(parts) != 3:
            continue
        comment, address_list, pattern = parts
        regex_entries.append((comment.strip(), address_list.strip(), pattern.strip()))

    comments = sorted(set(x[0] for x in regex_entries))
    for comment in comments:
        lines.append(f'/ip dns static remove [find where comment="{comment}"]')

    for comment, address_list, pattern in regex_entries:
        lines.append(
            f'add regexp="{pattern}" type=FWD '
            f'address-list={address_list} comment="{comment}"'
        )

    if regex_entries:
        lines.append("")

    return lines


def main():
    OUT.parent.mkdir(parents=True, exist_ok=True)

    lines = [
        "# auto-generated",
        "/ip dns static",
        "",
    ]

    for filename, comment, address_list in GROUPS:
        lines.extend(build_normal_group(filename, comment, address_list))

    lines.extend(build_regex_group())

    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Generated {OUT}")


if __name__ == "__main__":
    main()
