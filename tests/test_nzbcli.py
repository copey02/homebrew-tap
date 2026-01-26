import importlib.machinery
import importlib.util
import json
import os
import tempfile
import unittest
from pathlib import Path

MODULE_PATH = Path(__file__).resolve().parents[1] / "bin" / "nzbcli"

loader = importlib.machinery.SourceFileLoader("nzbcli", str(MODULE_PATH))
spec = importlib.util.spec_from_loader(loader.name, loader)
nzbcli = importlib.util.module_from_spec(spec)
loader.exec_module(nzbcli)


class EnvVarGuard:
    def __init__(self, mapping):
        self.mapping = mapping
        self.original = {}

    def __enter__(self):
        for key, value in self.mapping.items():
            self.original[key] = os.environ.get(key)
            if value is None:
                os.environ.pop(key, None)
            else:
                os.environ[key] = value
        return self

    def __exit__(self, exc_type, exc, tb):
        for key, value in self.original.items():
            if value is None:
                os.environ.pop(key, None)
            else:
                os.environ[key] = value


class ConfigTests(unittest.TestCase):
    def test_load_config_accepts_prowlarr_only(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            config_path = Path(tmpdir) / "config.json"
            config_path.write_text(
                json.dumps(
                    {
                        "prowlarr_url": "http://localhost:9696",
                        "prowlarr_api_key": "abc123",
                    }
                )
            )
            with EnvVarGuard(
                {
                    "NZBCLI_CONFIG_PATH": str(config_path),
                    "NZBCLI_API_KEY": None,
                    "NZBCLI_API_URL": None,
                    "NZBCLI_PROWLARR_URL": None,
                    "NZBCLI_PROWLARR_API_KEY": None,
                }
            ):
                config = nzbcli.load_config()
        self.assertEqual(config["prowlarr_url"], "http://localhost:9696")
        self.assertEqual(config["prowlarr_api_key"], "abc123")

    def test_load_config_requires_any_backend(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            config_path = Path(tmpdir) / "config.json"
            config_path.write_text(json.dumps({}))
            with EnvVarGuard(
                {
                    "NZBCLI_CONFIG_PATH": str(config_path),
                    "NZBCLI_API_KEY": None,
                    "NZBCLI_API_URL": None,
                    "NZBCLI_PROWLARR_URL": None,
                    "NZBCLI_PROWLARR_API_KEY": None,
                }
            ):
                with self.assertRaises(SystemExit):
                    nzbcli.load_config()


class BackendSelectionTests(unittest.TestCase):
    class Args:
        def __init__(self, nzbgeek=False):
            self.nzbgeek = nzbgeek

    def test_use_prowlarr_prefers_config(self):
        config = {"prowlarr_url": "http://localhost:9696", "prowlarr_api_key": "abc"}
        self.assertTrue(nzbcli.use_prowlarr(self.Args(), config))
        self.assertFalse(nzbcli.use_prowlarr(self.Args(nzbgeek=True), config))


class ProwlarrParsingTests(unittest.TestCase):
    def test_parse_prowlarr_items(self):
        releases = [
            {
                "title": "Example.Release.1080p",
                "size": 1073741824,
                "publish_date": "2025-01-01T12:00:00Z",
                "guid": "guid-1",
                "download_url": "http://example/nzb",
                "indexer": "NZBGeek",
            }
        ]
        items = nzbcli.parse_prowlarr_items(releases)
        self.assertEqual(len(items), 1)
        self.assertEqual(items[0]["title"], "Example.Release.1080p")
        self.assertEqual(items[0]["size_bytes"], 1073741824)
        self.assertEqual(items[0]["guid"], "guid-1")
        self.assertEqual(items[0]["download_url"], "http://example/nzb")
        self.assertEqual(items[0]["indexer"], "NZBGeek")


class UrlDetectionTests(unittest.TestCase):
    def test_is_url(self):
        self.assertTrue(nzbcli.is_url("https://example.com/nzb"))
        self.assertTrue(nzbcli.is_url("http://localhost:9696/api"))
        self.assertFalse(nzbcli.is_url("not-a-url"))


class DefaultResolutionTests(unittest.TestCase):
    def test_default_resolution_disabled(self):
        config = {"default_resolution": "1080p"}
        query = nzbcli.apply_default_resolution("Fringe S01E01", config, False)
        self.assertEqual(query, "Fringe S01E01")

    def test_default_resolution_enabled_adds(self):
        config = {"default_resolution": "1080p"}
        query = nzbcli.apply_default_resolution("Fringe S01E01", config, True)
        self.assertEqual(query, "Fringe S01E01 1080p")

    def test_default_resolution_enabled_no_dup(self):
        config = {"default_resolution": "1080p"}
        query = nzbcli.apply_default_resolution("Fringe S01E01 1080p", config, True)
        self.assertEqual(query, "Fringe S01E01 1080p")


if __name__ == "__main__":
    unittest.main()
