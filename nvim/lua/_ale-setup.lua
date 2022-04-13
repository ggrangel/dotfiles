-- vim.cmd [[ let g:ale_linters = {'python': ['flake8', 'bandit', 'mypy'], 'bash': ['shellchecker']} ]]
vim.cmd [[ let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black', 'isort'], 'lua': ['prettier']} ]]
vim.cmd [[ let g:ale_fix_on_save = 1 ]]
