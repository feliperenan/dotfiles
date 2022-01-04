-- LSP
require("settings.lsp_handlers").setup()

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("settings.lsp_handlers").on_attach,
		capabilities = require("settings.lsp_handlers").capabilities,
	}

  if server.name == "sumneko_lua" then
    local sumneko_opts = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'use' }
          }
        }
      }
    }
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "elixirls" then
    vim.notify "Setting up ElixirLS options"

    local elixirls_opts = {
      settings = {
        elixirLS  = {
          dialyzerEnabled = false,
          fetchDeps = false
        }
      }
    }
    opts = vim.tbl_deep_extend("force", elixirls_opts, opts)
  end

  server:setup(opts)
end)

