<%!
    import config.project
    import user.personal
%>${config.project.project_name}
${'=' * len(config.project.project_name)}

${config.project.project_long_description}

${config.project.project_description}

	${user.personal.personal_origin}, ${config.project.project_copyright_years}
