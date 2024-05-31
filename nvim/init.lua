-- That is where all my neovim config is set plus some keybinds.
require 'config'

-- Install `lazy.nvim` plugin manager. It is going to automatically download
-- Lazy in case setting up for the first time.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set lazy_options over here in case you need some.
local lazy_options = {}

-- This is going to load all plugins within lua/plugins.lua and lua/plugins/*
require('lazy').setup('plugins', lazy_options)
