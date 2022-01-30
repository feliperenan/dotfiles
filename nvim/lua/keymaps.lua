-- Aliases
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Create a vertical split
map('n', '<leader>l', ':vsplit<CR><C-w>l', default_opts)

-- Remap ESC to not close the test window.
-- tnoremap <Esc> <C-\><C-n>
map('n', '<Esc>', '<C-><C-n>', default_opts)

-- Create a horizontal split
map('n', '<leader>j', ':split<CR><C-w>j', default_opts)

-- Clear search highlight
map('n', '<leader>dh', ':nohl<CR>', default_opts)

-- Find & Replace with <leader> r from previous search.
map('n', '<leader>r', ':%s///g<Left><Left>', default_opts)

-- Fast saving with <leader> and w
map('n', '<leader>w', ':w<CR>', default_opts)

-- Search word under cursor without moving the cursor. Useful for using cgn and then change next words.
map('n', '*', '*``', default_opts)
map('n', '#', '#``', default_opts)

-- Disable arrow keys
map('', '<up>', '<nop>', { noremap = true })
map('', '<down>', '<nop>', { noremap = true })
map('', '<left>', '<nop>', { noremap = true })
map('', '<right>', '<nop>', { noremap = true })

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- Close all windows and exit from neovim
map('n', '<leader>q', ':qa!<CR>', default_opts)

-- Copy the current path to clipboard
map('n', '<leader>y', ":let @+=expand('%:p')<CR>", default_opts)

-- Copy the current path to clipboard with line number.
map('n', '<leader>yl', ":let @+=expand('%:p') . ':' . line('.')<CR>", default_opts)

-- Quickly open a buffer for scribble
map('n', '<leader>x', ':e ~/buffer<CR>', default_opts)

-- Close all the buffers but keep the current one.
map('n', '<leader>bq', ':%bd | e#| bd#', default_opts)

-- Vim-test key bindings
map('n', '<leader>tt', ':TestFile<CR>', default_opts)
map('n', '<leader>ts', ':TestNearest<CR>', default_opts)
map('n', '<leader>ta', ':TestSuite<CR>', default_opts)
map('n', '<leader>tl', ':TestLast<CR>', default_opts)
map('n', '<leader>tv', ':TestVisit<CR>', default_opts)

-- Zoom a vim pane, <C-w>= to re-balance
map('n', '<leader>-', ':wincmd _<cr>:wincmd |<cr>', default_opts)
map('n', '<leader>=', ':wincmd =<cr>', default_opts)

-- Telescope
map('n', '<leader>p', "<cmd>lua require('telescope.builtin').find_files()<CR>", default_opts)
map('n', '<leader>f', "<cmd>lua require('telescope.builtin').live_grep()<CR>", default_opts)
map('n', 'K', "<cmd>lua require('telescope.builtin').grep_string()<CR>", default_opts)
map('n', '<leader>bo', "<cmd>lua require('telescope.builtin').buffers()<CR>", default_opts)
map('n', '<leader>t', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", default_opts)
map('n', '<leader>co', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", default_opts)
map('n', '<leader>gc', "<cmd>lua require('telescope.builtin').git_branches()<CR>", default_opts)
map('n', '<leader>gc', "<cmd>lua require('settings/telescope').git_branches()<CR>", default_opts)
map('n', '<leader>vr', "<cmd>lua require('settings/telescope').load_vimrc_files()<CR>", default_opts)


-- NVIM tree
map('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', default_opts)
