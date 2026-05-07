-- LSP Configuration & Plugins
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim.
      -- We use mason-tool-installer to install binaries, and configure servers
      -- ourselves via vim.lsp.config / vim.lsp.enable (mason-lspconfig is no
      -- longer needed).
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gd', '<cmd>lua vim.lsp.buf.definition()<cr>', '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Format on save via the attached LSP (e.g. dexter for Elixir).
          -- Scoped per-buffer so it only fires for buffers where the server attached.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method 'textDocument/formatting' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-format-' .. event.buf, { clear = true }),
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format {
                  bufnr = event.buf,
                  id = client.id,
                  timeout_ms = 5000,
                }
              end,
            })
          end
        end,
      })

      -- Show diagnostics under the cursor when holding position
      vim.diagnostic.config {
        virtual_text = false,
        float = {
          source = true,
          header = '',
          prefix = '',
        },
      }
      vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        pattern = '*',
        callback = function()
          for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
              return
            end
          end
          vim.diagnostic.open_float(0, {
            scope = 'line',
            focusable = false,
            close_events = {
              'CursorMoved',
              'CursorMovedI',
              'BufHidden',
              'WinLeave',
            },
          })
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Language server configurations.
      --
      -- Single source of truth: every server is added here with the same shape,
      -- regardless of how its binary is installed. Each entry is the config you
      -- would pass to `vim.lsp.config(name, ...)` (see `:help vim.lsp.config`).
      --
      -- Optional non-LSP keys consumed by the loop below:
      --   - mason (string|false): Mason package name to auto-install. Defaults
      --     to the server name. Set to `false` for servers installed by other
      --     means (Homebrew, mise, asdf, system package manager, etc.).
      --
      -- Defaults from nvim-lspconfig's bundled `lsp/<name>.lua` files (e.g.
      -- `cmd`, `root_markers`, `filetypes`) are merged automatically by
      -- `vim.lsp.config`, so you only need to specify overrides.
      --
      -- Common override keys:
      --   - cmd (table): Override the default command used to start the server
      --   - filetypes (table): Override the default associated filetypes
      --   - capabilities (table): Override fields in capabilities
      --   - settings (table): Override settings sent on server initialization
      --   - init_options (table): Server-specific initialization options
      local servers = {
        -- Examples — see `:help lspconfig-all` for the full list:
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ts_ls = {},

        lua_ls = {
          -- nvim-lspconfig uses `lua_ls` but the Mason registry package is
          -- named `lua-language-server`.
          mason = 'lua-language-server',
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- Toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = {
                disable = { 'missing-fields' },
              },
            },
          },
        },

        -- Dexter (Elixir LSP) — installed via Homebrew, so opt out of Mason.
        -- nvim-lspconfig doesn't ship a default for dexter, so we provide the
        -- full config here. https://github.com/remoteoss/dexter
        dexter = {
          mason = false,
          cmd = { 'dexter', 'lsp' },
          root_markers = { '.dexter/dexter.db', '.dexter.db', '.git', 'mix.exs' },
          filetypes = { 'elixir', 'eelixir', 'heex' },
          init_options = {
            followDelegates = true,
          },
        },

        -- elixirls = {
        --   settings = {
        --     elixirLS = {
        --       dialyzerEnabled = false,
        --       fetchDeps = false,
        --     },
        --   },
        -- },

        -- lexical = {
        --   mason = false,
        --   cmd = { vim.fn.expand '~/source/opensource/expert/apps/expert/burrito_out/expert_darwin_arm64' },
        --   filetypes = { 'elixir', 'eelixir', 'heex' },
        --   settings = {},
        -- },
      }

      -- Register every server with vim.lsp.config (merging with any defaults
      -- shipped by nvim-lspconfig) and enable it.
      local mason_ensure = {}
      for name, cfg in pairs(servers) do
        local mason_pkg = cfg.mason
        cfg.mason = nil

        cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)

        if mason_pkg ~= false then
          table.insert(mason_ensure, type(mason_pkg) == 'string' and mason_pkg or name)
        end
      end

      -- Mason just installs binaries; it doesn't configure servers anymore.
      -- Run `:Mason` to inspect installed tools (press `g?` for help).
      require('mason').setup()

      -- Extra tools (formatters, linters, etc.) to keep installed alongside
      -- the LSP servers listed above.
      vim.list_extend(mason_ensure, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = mason_ensure }
    end,
  },
}
