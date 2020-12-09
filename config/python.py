import config.project

package_name = config.project.project_name

console_scripts = [
]

setup_requires = [
]

run_requires = [
    'flask',  # for a web framework
]

test_requires = [
]

dev_requires = [
    'pydmt',  # for templating
    'pymakehelper',  # for the makefile
]

install_requires = list(setup_requires)
install_requires.extend(run_requires)

python_requires = ">=3.5"
