vim.cmd([[
let test#neovim#term_position = "vert"
let test#strategy = "neovim"
let g:test#echo_command = 0
let g:test#neovim#start_normal = 1
" let g:test#preserve_screen = 0  " Clear screen from previous run
if has('nvim')
  tmap <C-o> <C-\><C-n> " C-o goes from TERMINAL INSERT mode to NORMAL mode
endif
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ti :TestFile<CR>
]])
