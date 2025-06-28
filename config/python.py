""" python deps for this project """

install_requires: list[str] = [
    "flask",
    "gunicorn",
]
build_requires: list[str] = [
    "pydmt",
    "pymakehelper",
    "pylint",
]
requires = install_requires + build_requires
