<%!
    import config.python
%># THIS IS AN AUTO-GENERATED FILE. DO NOT EDIT!
% if config.python.run_requires:
# run requirements
% for a in config.python.run_requires:
${a}
% endfor
% endif
