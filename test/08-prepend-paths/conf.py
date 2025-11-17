import sys
from pathlib import Path

root = Path(__file__).resolve().parent
sys.path.insert(0, str((root / "../resources/_extensions").resolve()))

project = "foo"
copyright = "2026, john-doe"
extensions = ["sphinx_env"]
templates_path = ["../resources/_templates"]
html_permalinks = False
