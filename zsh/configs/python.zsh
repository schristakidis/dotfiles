# Find python file
alias pyfind='find . -name "*.py"'

# Remove python compiled byte-code and mypy cache in either current directory or in a
# list of specified directories
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name ".mypy_cache" -delete
	find ${ZSH_PYCLEAN_PLACES} -type d -name "_trial_temp" -exec rm -rv {} +
}

# Grep among .py files
alias pygrep='grep --include="*.py"'
