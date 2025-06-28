-- List of plugins that I didn't want to create a file in plugins/ folder. Most
-- of the plugins added here doesn't have much config or doesn't change that
-- much. Having the plugin on its own file make it easier to change once it can
-- be located via `<leader>sn`.
return {
  -- Trying copilot
  { 'github/copilot.vim' },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      -- indent = { enabled = true },
      -- input = { enabled = true },
      -- picker = { enabled = true },
      notifier = { enabled = true },
      -- quickfile = { enabled = true },
      scroll = { enabled = true },
      bufdelete = { enabled = true },
      animate = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
  },

  {
    'vim-test/vim-test',
    init = function()
      vim.cmd [[ let g:test#strategy = "toggleterm" ]]
      vim.cmd [[ let g:test#runner_commands = ['ExUnit'] ]]
    end,
    dependencies = {
      {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
          -- Configure toggleterm with a floating window
          float_opts = {
            border = 'curved', -- Rounded corners
            width = function()
              return math.floor(vim.o.columns * 0.8) -- 80% of screen width
            end,
            height = function()
              return math.floor(vim.o.lines * 0.8)
            end,
          },
          direction = 'float',
          start_in_insert = false,
        },
      },
      { 'tpope/vim-dispatch' },
    },
  },

  -- Add commands as :A to go to alternate files. Such as the test file
  -- of the current buffer.
  { 'tpope/vim-projectionist' },
  { 'dkuku/vim-projectionist-elixir' },

  -- Multi line cursor.
  { 'mg979/vim-visual-multi' },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})
  --
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      local wk = require 'which-key'
      wk.setup()

      -- Document existing key chains
      wk.add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>h', group = '[G]it Hunk' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>tf', '<cmd>TestFile<cr>', desc = 'File' },
        { '<leader>tn', '<cmd>TestNearest<cr>', desc = 'Nearest' },
        { '<leader>ts', '<cmd>TestSuite<cr>', desc = 'Suite' },
        { '<leader>tt', '<cmd>:ToggleTerm<cr>', desc = 'Toggle term' },
        { '<leader>tx', '<cmd>ExUnit --failed -strategy=dispatch<cr>', desc = 'ExUnit failed tests' },
        { '<leader>w', group = '[W]orkspace' },
      }
    end,
  },
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- List colorschemes via `:Telescope colorscheme`. or :colorscheme my-color
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    lazy = true,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'catppuccin'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      require('catppuccin').setup {
        no_italic = true,
        transparent_background = true,
        integrations = {
          mason = true,
          neotree = true,
        },
      }
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end
      require('mini.tabline').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
      --  It has a Start as well, but for now I'm testing dashboard.
      -- require('mini.starter').setup()
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'elixir',
        'git_rebase',
        'git_config',
        'gitcommit',
        'gitignore',
      },

      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        view_options = {
          show_hidden = true,
        },
        skip_confirm_for_simple_edits = true,
      }
      -- set keymap to open oil window
      vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>Oil --float<cr>', { noremap = true, silent = true })
    end,
  },
}
