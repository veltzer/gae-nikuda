config_requires = []
dev_requires = []
install_requires = [
    "flask",
    "gunicorn",
]
build_requires = [
    "pymakehelper",
    "pydmt",
    "pylint",
]
test_requires = []
requires = config_requires + install_requires + build_requires + test_requires
