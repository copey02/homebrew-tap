import importlib.machinery
import importlib.util
import tempfile
import unittest
from pathlib import Path

MODULE_PATH = Path(__file__).resolve().parents[1] / "bin" / "mediacli"

loader = importlib.machinery.SourceFileLoader("mediacli", str(MODULE_PATH))
spec = importlib.util.spec_from_loader(loader.name, loader)
mediacli = importlib.util.module_from_spec(spec)
loader.exec_module(mediacli)


class ParseFilenameTests(unittest.TestCase):
    def test_parse_tv_filename(self):
        info = mediacli.parse_filename("Show.Name.S01E02.1080p.BluRay.x264-DON.mkv")
        self.assertEqual(info["type"], "tv")
        self.assertEqual(info["season"], 1)
        self.assertEqual(info["episode"], 2)
        self.assertEqual(info["title"], "Show Name")
        self.assertEqual(info["resolution"], "1080p")
        self.assertEqual(info["source"], "BluRay")
        self.assertEqual(info["codec"], "H.264")
        self.assertEqual(info["group"], "DON")

    def test_group_ignores_codec_suffix(self):
        info = mediacli.parse_filename(
            "Northern.Exposure.S01E01.Pilot.1080p.DD2.0.AVC.REMUX-FraMeSToR-hevc.mkv"
        )
        self.assertEqual(info["group"], "FraMeSToR")

    def test_parse_movie_filename(self):
        info = mediacli.parse_filename("Some.Movie.2020.2160p.WEB-DL.H265.DTS-HD.MA.5.1.mkv")
        self.assertEqual(info["type"], "movie")
        self.assertEqual(info["title"], "Some Movie")
        self.assertEqual(info["year"], 2020)
        self.assertEqual(info["resolution"], "2160p")
        self.assertEqual(info["codec"], "HEVC")
        self.assertEqual(info["audio"], "DTS-HD MA")
        self.assertEqual(info["audio_channels"], "5.1")


class FormatTests(unittest.TestCase):
    def test_format_tv_episode_range(self):
        name = mediacli.format_tv_name(
            show="Show",
            year="2019",
            season=1,
            episode=1,
            episode_end=2,
            title="Pilot",
            info={},
            pattern=mediacli.DEFAULT_TV_PATTERN,
        )
        self.assertEqual(name, "Show (2019) - S01E01-E02 - Pilot")

    def test_format_tv_episode_range_legacy_pattern(self):
        pattern = "{show} - S{season:02d}E{episode:02d} - {title}"
        name = mediacli.format_tv_name(
            show="Show",
            year="2019",
            season=1,
            episode=1,
            episode_end=2,
            title="Pilot",
            info={},
            pattern=pattern,
        )
        self.assertIn("S01E01-E02", name)


class CollisionTests(unittest.TestCase):
    def test_resolve_collisions_unique(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            tmp = Path(tmpdir)
            src1 = tmp / "a.mkv"
            src2 = tmp / "b.mkv"
            dest = tmp / "out.mkv"
            src1.write_text("a")
            src2.write_text("b")
            dest.write_text("existing")

            ops = [(src1, dest), (src2, dest)]
            result = mediacli.resolve_collisions(ops, "unique")
            dests = [d for _, d in result]

            self.assertEqual(len(dests), 2)
            self.assertEqual(len(set(dests)), 2)
            for d in dests:
                self.assertNotEqual(d.name, "out.mkv")


if __name__ == "__main__":
    unittest.main()
