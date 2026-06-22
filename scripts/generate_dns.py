from ipaddress import ip_network
from pathlib import Path
import re


BASE = Path(".")
DOMAINS_DIR = BASE / "domains"
NETWORKS_DIR = BASE / "networks"
OUT = BASE / "generated" / "dns-auto.rsc"

# Старый regex.txt пока не обрабатываем
IGNORED_DOMAIN_FILES = {"regex.txt"}


def read_lines(path: Path) -> list[str]:
    """Читает непустые уникальные строки без комментариев."""
    result = set()

    for raw in path.read_text(encoding="utf-8").splitlines():
        value = raw.strip().lower()

        if not value or value.startswith("#"):
            continue

        result.add(value)

    return sorted(result)


def get_group_name(path: Path) -> str:
    """Получает название группы из имени файла."""
    group = path.stem.lower()

    if not re.fullmatch(r"[a-z0-9_-]+", group):
        raise ValueError(
            f"Недопустимое имя файла: {path.name}. "
            "Используйте латинские буквы, цифры, дефис или подчёркивание."
        )

    return group


def build_domain_groups() -> list[str]:
    lines = []

    if not DOMAINS_DIR.exists():
        return lines

    for path in sorted(DOMAINS_DIR.glob("*.txt")):
        if path.name.lower() in IGNORED_DOMAIN_FILES:
            continue

        group = get_group_name(path)
        domains = read_lines(path)

        comment = f"github:{group}"
        address_list = f"to-mihomo-{group}"

        # Удаляем предыдущую версию группы.
        # Это выполняется даже для пустого файла, чтобы очистить старые записи.
        lines.append(
            f'/ip dns static remove [find where comment="{comment}"]'
        )

        for domain in domains:
            if any(char in domain for char in ['"', " ", "|"]):
                raise ValueError(
                    f"Некорректный домен в {path}: {domain}"
                )

            lines.append(
                f"/ip dns static add "
                f'name="{domain}" '
                f"type=FWD "
                f"match-subdomain=yes "
                f"address-list={address_list} "
                f'comment="{comment}"'
            )

        lines.append("")

    return lines


def normalize_ipv4(value: str, path: Path) -> str:
    """Проверяет и нормализует IPv4-адрес или подсеть."""
    try:
        network = ip_network(value, strict=False)
    except ValueError as error:
        raise ValueError(
            f"Некорректный IP или CIDR в {path}: {value}"
        ) from error

    if network.version != 4:
        raise ValueError(
            f"IPv6 пока не поддерживается в {path}: {value}"
        )

    # Одиночный адрес оставляем без /32
    if network.prefixlen == 32:
        return str(network.network_address)

    return str(network)


def build_network_groups() -> list[str]:
    lines = []

    if not NETWORKS_DIR.exists():
        return lines

    for path in sorted(NETWORKS_DIR.glob("*.txt")):
        group = get_group_name(path)
        addresses = read_lines(path)

        comment = f"github:network:{group}"
        address_list = f"to-mihomo-{group}"

        # Удаляем только записи, созданные этим генератором
        lines.append(
            "/ip firewall address-list remove "
            f'[find where comment="{comment}"]'
        )

        for value in addresses:
            address = normalize_ipv4(value, path)

            lines.append(
                "/ip firewall address-list add "
                f"list={address_list} "
                f"address={address} "
                f'comment="{comment}"'
            )

        lines.append("")

    return lines


def main():
    OUT.parent.mkdir(parents=True, exist_ok=True)

    lines = [
        "# auto-generated; do not edit manually",
        "",
        "# DNS domain groups",
        "",
    ]

    lines.extend(build_domain_groups())

    lines.extend([
        "# Static IP and network groups",
        "",
    ])

    lines.extend(build_network_groups())

    OUT.write_text(
        "\n".join(lines).rstrip() + "\n",
        encoding="utf-8",
    )

    print(f"Generated {OUT}")


if __name__ == "__main__":
    main()
