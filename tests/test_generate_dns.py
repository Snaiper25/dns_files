import importlib.util
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("generate_dns", ROOT / "scripts" / "generate_dns.py")
MODULE = importlib.util.module_from_spec(SPEC)
assert SPEC.loader
SPEC.loader.exec_module(MODULE)


class GeneratorTests(unittest.TestCase):
    def test_domain_normalization(self):
        self.assertEqual(MODULE.normalize_domain("domain:Example.COM @tag"), "example.com")
        self.assertEqual(MODULE.normalize_domain("full:api.example.com"), "api.example.com")
        self.assertIsNone(MODULE.normalize_domain("regexp:.*example.*"))

    def test_output_has_expected_groups(self):
        sources = json.loads(MODULE.SOURCES_FILE.read_text())
        groups = MODULE.load_domain_groups(sources)
        output = MODULE.render(groups, MODULE.load_network_groups())
        for group in ("ai", "instagram", "sites", "telegram", "whatsapp", "youtube"):
            self.assertIn(f"address-list=to-vpn-{group}", output)

    def test_dangerously_broad_domains_are_absent(self):
        sources = json.loads(MODULE.SOURCES_FILE.read_text())
        groups = MODULE.load_domain_groups(sources)
        all_domains = set().union(*groups.values())
        for domain in ("amazonaws.com", "googleusercontent.com", "facebook.com"):
            self.assertNotIn(domain, all_domains)

    def test_private_and_broad_networks_are_rejected(self):
        with self.assertRaises(ValueError):
            MODULE.normalize_network("192.168.0.0/16", Path("test"))
        with self.assertRaises(ValueError):
            MODULE.normalize_network("8.0.0.0/8", Path("test"))


if __name__ == "__main__":
    unittest.main()
