-- GIT plugins
return {
  -- LazyGit
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gl', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  --- Git signs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Open Github at the current line
  {
    'ruifm/gitlinker.nvim',
    config = function()
      local gitlinker = require 'gitlinker'
      local actions = require 'gitlinker.actions'

      gitlinker.setup {
        opts = {
          action_callback = actions.open_in_browser,
        },

        callbacks = {
          -- I need a custom setup for Dice because of my Dice git setup.
          ['dicefm'] = function(url_data)
            local url = 'https://github.com/' .. url_data.repo .. '/blob/' .. url_data.rev .. '/' .. url_data.file
            if url_data.lstart then
              url = url .. '#L' .. url_data.lstart
              if url_data.lend then
                url = url .. '-L' .. url_data.lend
              end
            end
            return url
          end,
        },
      }
    end,
  },
}
