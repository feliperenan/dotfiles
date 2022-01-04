-- Aliases
local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

-- General
g.mapleader = ' '             -- set leader to a space

-- UI
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile
opt.ruler = true
opt.cmdheight = 1
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.errorbells = true
opt.visualbell = true
opt.number = true             -- show line number
opt.showmatch = true          -- highlight matching parenthesis
-- opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.splitright = true         -- vertical split to the right
opt.splitbelow = true         -- orizontal split to the bottom
opt.ignorecase = true         -- ignore case letters when search
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.linebreak = true          -- wrap on word boundary
opt.hidden = true             -- enable background buffers
opt.history = 100             -- remember n lines in history
opt.lazyredraw = true         -- faster scrolling
opt.synmaxcol = 240           -- max column for syntax highlight
opt.foldcolumn = '1'          -- Add a bit extra margin to the left
opt.relativenumber = true
opt.cursorline = true
opt.fileencoding = "utf-8"
opt.termguicolors = true
opt.grepprg = "rg --vimgrep --smart-case --follow"

-- Colorschema
opt.background = 'dark'
cmd [[ colorscheme nightfox]]

-- Startify
cmd [[ let g:startify_relative_path = 1 ]]
cmd [[ let g:startify_change_to_vcs_root = 1 ]]

-- Tabs, Indent
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 2        -- shift 4 spaces when tab
opt.tabstop = 2           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript,lua setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- Remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- Return to last edit position when opening files (You want this!)
cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- Mix format on Save
cmd [[let g:mix_format_on_save = 1]]

-- Highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-- VIM Test
cmd('let g:test#preserve_screen = 1')
cmd("let g:test#filename_modifier = ':.'")

-- NERD tree
cmd [[ let NERDTreeMinimalUI = 1 ]]
cmd [[ let NERDTreeDirArrows = 1 ]]
cmd [[ let g:NERDTreeIgnore=['\~$', 'deps', '_build'] ]]
cmd [[ let NERDTreeShowHidden=1 ]]

-- Telescope
local telescope = require("telescope")

telescope.setup{
  defaults = {
    preview = false,
  },
  pickers = {
    find_files = {
      theme = "ivy",
    }
  }
}

telescope.load_extension("git_worktree")

--  Lua Airline
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '|', right = '|'},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Treesitter
local configs = require 'nvim-treesitter.configs'

configs.setup {
  ensure_installed = "maintained", -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = true,
  },
  indent = {
    enable = false, -- default is disabled anyways
  }
}

