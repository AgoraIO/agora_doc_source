"""Tests for xml2json.

Run with:  python3 -m unittest discover -s xml2json -p 'test_*.py'
"""

import re
import sys
import unittest
from pathlib import Path

# xml2json parses arguments at import time, so give it a valid command line.
sys.argv = ["xml2json.py", "--working_dir", ".", "--platform_tag", "ios"]
sys.path.insert(0, str(Path(__file__).parent))

from xml2json import MARKDOWN_PLATFORMS, PLATFORM_GROUPS, should_remove, symbol_link  # noqa: E402

SOURCE = (Path(__file__).parent / "xml2json.py").read_text(encoding="utf-8")


class SymbolLinkTest(unittest.TestCase):
    def test_wraps_symbol_names_on_markdown_platforms(self) -> None:
        for platform in sorted(MARKDOWN_PLATFORMS):
            with self.subTest(platform=platform):
                self.assertEqual(
                    symbol_link("AgoraVideoStreamType", platform),
                    "``AgoraVideoStreamType``",
                )

    def test_leaves_other_platforms_untouched(self) -> None:
        for platform in ("unity", "flutter", "rn", "electron", "cpp", "android"):
            with self.subTest(platform=platform):
                self.assertEqual(
                    symbol_link("AgoraVideoStreamType", platform),
                    "AgoraVideoStreamType",
                )

    def test_leaves_prose_targets_untouched(self) -> None:
        # A target containing a space is not a symbol name, so wrapping it would
        # render a meaningless code span rather than a link.
        self.assertEqual(symbol_link("technical support", "ios"), "technical support")

    def test_empty_target_is_unchanged(self) -> None:
        self.assertEqual(symbol_link("", "ios"), "")

    def test_objective_c_selectors_are_wrapped(self) -> None:
        self.assertEqual(
            symbol_link("joinChannelByToken:channelId:uid:", "ios"),
            "``joinChannelByToken:channelId:uid:``",
        )


class PlatformPropsTest(unittest.TestCase):
    """The corpus spells macOS "mac"; the build asks for "macos"."""

    def test_mac_is_kept_on_the_macos_build(self) -> None:
        # props on the macOS-only cases of enum_localaudiostreamreason
        self.assertFalse(
            should_remove("macos", "cpp mac unreal bp unity flutter electron cs", "rtc", "en")
        )

    def test_mac_does_not_widen_other_platforms(self) -> None:
        for platform in ("ios", "android", "unity", "flutter", "rn", "electron", "cpp"):
            with self.subTest(platform=platform):
                self.assertTrue(should_remove(platform, "mac", "rtc", "en"))

    def test_apple_and_native_still_include_macos(self) -> None:
        self.assertFalse(should_remove("macos", "apple", "rtc", "en"))
        self.assertFalse(should_remove("macos", "native", "rtc", "en"))

    def test_group_tokens_are_not_platforms_themselves(self) -> None:
        # a group token must expand, never match a --platform_tag directly
        for token in PLATFORM_GROUPS:
            with self.subTest(token=token):
                self.assertNotIn(token, PLATFORM_GROUPS[token])


class XrefResolutionTest(unittest.TestCase):
    """Guards every branch that resolves an <xref> to display text.

    An <xref> is resolved in three places -- by keyref, by href with a
    fragment, and by href naming a file. A branch that assigns xref.text
    without going through symbol_link silently drops the link on iOS and
    macOS, which is how file-level hrefs such as
    <xref href="class_livetranscoding.dita"/> were missed.
    """

    def _assignments(self):
        for line in SOURCE.splitlines():
            stripped = line.strip()
            if stripped.startswith("#"):
                continue
            if re.match(r"xref\.text\s*=", stripped):
                yield stripped

    def test_every_branch_routes_through_symbol_link(self) -> None:
        assignments = list(self._assignments())
        self.assertGreaterEqual(len(assignments), 3, "expected all three xref branches")
        for assignment in assignments:
            with self.subTest(assignment=assignment):
                # The http branch appends a URL rather than naming a symbol.
                if "xref.get(\"href\")" in assignment:
                    continue
                self.assertIn("symbol_link(", assignment)

    def test_file_level_href_branch_is_covered(self) -> None:
        # Regression: this branch resolves <xref href="class_livetranscoding.dita"/>
        # and previously assigned title_text.strip() directly.
        self.assertIn(
            "xref.text = symbol_link(title_text.strip(), platform_tag)", SOURCE
        )


if __name__ == "__main__":
    unittest.main()
