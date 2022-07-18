--[[
This is supposed to override Lunar Vim default. Use the command bellow to create
a sys link to this file instead.

-- backup original config if you ever needed it.
mv ~/.config/lvim/config.lua ~/.config/lvim/config.lua.bkp
ln -s ~/dotfiles/lvim/config.lua ~/.config/lvim/config.lua
]]

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "everforest"
vim.o.background = "dark"


-- CUSTOM MAPPINGS
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Find & Replace with <leader> r from previous search.
map('n', '<leader>r', ':%s///g<Left><Left>', { noremap = true, silent = false })

-- Copy the current path to clipboard
map('n', '<leader>y', ":let @+=expand('%:p')<CR>", default_opts)

-- Copy the current path to clipboard with line number.
map('n', '<leader>yl', ":let @+=expand('%:p') . ':' . line('.')<CR>", default_opts)

-- Quickly open a buffer for scribble
map('n', '<leader>x', ':e ~/buffer<CR>', default_opts)

-- Zoom a vim pane, <C-w>= to re-balance
map('n', '<leader>-', ':wincmd _<cr>:wincmd |<cr>', default_opts)
map('n', '<leader>=', ':wincmd =<cr>', default_opts)


-- keymappings [view all the defaults by pressing <leader>Lk]
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.visual_mode["K"] = ""
lvim.keys.visual_mode["J"] = ""

-- customize mappings
local which_key = lvim.builtin.which_key.mappings

which_key["t"] = {
  name = "Test",
  f = { "<cmd>TestFile<cr>", "File" },
  n = { "<cmd>TestNearest<cr>", "Nearest" },
  s = { "<cmd>TestSuite<cr>", "Suite" },
}

which_key["f"] = { "<cmd>Telescope find_files<cr>", "Find File" }

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.change_dir.restrict_above_cwd = true
-- keep file tree in the opened directory.
lvim.builtin.project.manual_mode = true


lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  -- Colorschemes
  { 'rose-pine/neovim' },
  { 'feliperenan/nord-vim' },
  { 'sainnhe/everforest' },

  -- VIM test
  { "vim-test/vim-test" },

  -- Add :Rename command so I can rename files as :Rename old new
  { 'danro/rename.vim' },

  -- Add commands as :A to go to alternate files. Such as the test file
  -- of the current buffer.
  { 'tpope/vim-projectionist' },
  { 'dkuku/vim-projectionist-elixir' },

  -- Improve VIM motion.
  -- { "ggandor/lightspeed.nvim", event = "BufRead" },

  -- VIM surround
  { "tpope/vim-surround" },

  -- Display indentation.
  { 'Yggdroot/indentLine' },

  { 'preservim/vimux' },

  { 'hauleth/sad.vim' }
}

vim.opt.relativenumber = true
-- Remove whitespace on save
vim.cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Return to last edit position when opening files (You want this!)
vim.cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- VIM TEST
vim.cmd [[ let g:test#strategy = "vimux" ]]

-- don't close the terminal by default.
vim.cmd [[ let g:test#neovim#start_normal = 1 ]]

-- Startify
vim.cmd [[ let g:startify_relative_path = 1 ]]
vim.cmd [[ let g:startify_change_to_vcs_root = 1 ]]
vim.cmd [[ set termguicolors ]]
