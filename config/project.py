import datetime
import config.general

project_name = "nIkUdAh"
project_long_description = "Nikuda web site"
project_year_started = 2004
project_description = """Nikuda is a web site intended to allow
users to get punctuation for hebrew words, sentences and paragraphs."""

project_copyright_years = ", ".join(
    map(str, range(int(project_year_started), datetime.datetime.now().year + 1)))
if str(config.general.general_current_year) == project_year_started:
    project_copyright_years = config.general.general_current_year
else:
    project_copyright_years = f"{project_year_started} - {config.general.general_current_year}"
