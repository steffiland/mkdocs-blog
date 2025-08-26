# macros/__init__.py
import importlib
import pathlib

package_dir = pathlib.Path(__file__).parent

for file in package_dir.glob("*.py"):
    if file.name != "__init__.py":
        module_name = f"{__name__}.{file.stem}"
        importlib.import_module(module_name)

