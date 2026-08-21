import unittest

from generate_icons_index import _glyph_names


class GlyphNamesTest(unittest.TestCase):
    def test_rejects_non_object_glyph_entries(self) -> None:
        report = {"glyphs": [None] * 318}

        with self.assertRaisesRegex(ValueError, "Invalid report glyph entry"):
            _glyph_names(report)


if __name__ == "__main__":
    unittest.main()
