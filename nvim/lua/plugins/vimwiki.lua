vim.cmd [[
let g:vimwiki_list = [{ 'path': '~/drive/GAGA/vimwiki', 'syntax': 'markdown', 'ext': '.md' }]
let g:vimwiki_ext2syntax = { '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown' }

" Makes vimwiki markdown links as [text](text.md) instead of [text](text)
let g:vimwiki_markdown_link_ext = 1

let g:markdown_folding = 1
]]
