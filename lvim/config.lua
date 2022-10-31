--[[
This is supposed to override Lunar Vim default. Use the command bellow to create
a sys link to this file instead.

-- backup original config if you ever needed it.
mv ~/.config/lvim/config.lua ~/.config/lvim/config.lua.bkp
ln -s ~/dotfiles/lvim/config.lua ~/.config/lvim/config.lua
]]

-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight-storm"

vim.o.background = "dark"
vim.o.relativenumber = true
vim.o.ls = 0
vim.o.ch = 0

-- Remove whitespace on save
vim.cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Return to last edit position when opening files (You want this!)
vim.cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- VIM TEST
vim.cmd [[ let g:test#strategy = "neovim" ]]

-- don't close the terminal by default.
-- vim.cmd [[ let g:test#neovim#start_normal = 1 ]]

-- Startify
vim.cmd [[ let g:startify_relative_path = 1 ]]
vim.cmd [[ let g:startify_change_to_vcs_root = 1 ]]
vim.cmd [[ set termguicolors ]]


-- CUSTOM MAPPINGS
-- keymappings [view all the defaults by pressing <leader>Lk]
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.visual_mode["K"] = ""
lvim.keys.visual_mode["J"] = ""

-- customize mappings for which key
local which_key = lvim.builtin.which_key.mappings

which_key["t"] = {
  name = "Test",
  f = { "<cmd>TestFile<cr>", "File" },
  n = { "<cmd>TestNearest<cr>", "Nearest" },
  s = { "<cmd>TestSuite<cr>", "Suite" },
}

which_key["y"] = { "<cmd>let @+=expand('%:~:.')<CR>", "Current path to clipboard" }
which_key["x"] = { "<cmd>e ~/buffer<CR>", "My notes" }
which_key["-"] = { "<cmd>wincmd _<CR>:wincmd |<CR>", "Win focus" }
which_key["="] = { ":wincmd =<CR>", "Win back to normal" }

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.change_dir.restrict_above_cwd = true
lvim.builtin.project.manual_mode = true -- keep file tree in the opened directory.
lvim.builtin.bufferline.mode = "buffers"
lvim.builtin.lualine.active = false


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
lvim.lsp.diagnostics.virtual_text = false

-- Additional Plugins
lvim.plugins = {
  -- Colorschemes
  { 'rose-pine/neovim' },
  { 'feliperenan/nord-vim' },
  { 'sainnhe/everforest' },
  { 'folke/tokyonight.nvim' },

  -- VIM test
  { "vim-test/vim-test" },
  { 'preservim/vimux' },

  -- Add :Rename command so I can rename files as :Rename old new
  { 'danro/rename.vim' },

  -- Add commands as :A to go to alternate files. Such as the test file
  -- of the current buffer.
  { 'tpope/vim-projectionist' },
  { 'dkuku/vim-projectionist-elixir' },

  -- VIM surround
  { "tpope/vim-surround" },

  -- Display indentation.
  { 'Yggdroot/indentLine' },

  -- Multi line cursor.
  { 'mg979/vim-visual-multi' }
}

vim.filetype.add({
  extension = {
    leex = 'heex',
    eex = 'heex'
  }
})
