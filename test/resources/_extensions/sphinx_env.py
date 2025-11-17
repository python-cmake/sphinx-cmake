import os
import sys
from docutils import nodes
from docutils.parsers.rst import Directive


_LIBRARY_PATH_MAP = {
    "win32": "PATH",
    "darwin": "DYLD_LIBRARY_PATH",
}


class Env(Directive):
    """
    Usage:
        .. env:: VAR_NAME
        .. env:: VAR_NAME N

    Special case:
        LIBRARY_PATH -> platform-specific library path variable

    If N is provided and the value is a list, only the first N entries
    are shown.
    """
    required_arguments = 1
    optional_arguments = 1
    has_content = False

    def run(self):
        name = self.arguments[0]

        if name == "LIBRARY_PATH":
            env_name = _LIBRARY_PATH_MAP.get(sys.platform, "LD_LIBRARY_PATH")
        else:
            env_name = name

        value = os.environ.get(env_name, "")

        if len(self.arguments) == 2:
            sep = ";" if sys.platform == "win32" else ":"
            value = sep.join(value.split(sep)[: int(self.arguments[1])])

        return [nodes.inline(text=value)]


def setup(app):
    app.add_directive("env", Env)
