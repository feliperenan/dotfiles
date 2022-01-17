local M = {}

local actions = require "telescope.actions"

-- Customize git branches command adding mapping to delete_branch
M.git_branches = function()
  require('telescope.builtin').git_branches({
    attach_mappings = function(_, map)
      map('i', 'c-d', actions.git_delete_branch)
      map('n', 'c-d', actions.git_delete_branch)
      return true
    end
  })
end

-- Load Vim RC files.
M.load_vimrc_files = function()
  require('telescope.builtin').find_files({
    prompt_title = '< VimRC >',
    cwd = '~/dotfiles/nvim/'
  })
end

return M
