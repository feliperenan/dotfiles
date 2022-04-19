---- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup our autocompletion. These configuration options are the default ones
-- copied out of the documentation.
local cmp = require("cmp")

-- For a better auto complete take a look at:
-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/cmp.lua
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  formatting = {
    fields = { "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        buffer = "[Buffer]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})


-- Setup Signs
local signs = {
  { name = "DiagnosticSignError", text = "e" },
  { name = "DiagnosticSignWarn", text = "w" },
  { name = "DiagnosticSignHint", text = "h" },
  { name = "DiagnosticSignInfo", text = "i" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- Attach the keymaps.
--
-- In case we want to enable specifics according to the client:
--
--   if client.name == "tsserver" then
--     client.resolved_capabilities.document_formatting = false
--   end
local on_attach = function(_, bufnr)
  local map = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }

  map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  map(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  map(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
end

-- LSP Installer
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end


lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
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
        elixirLS = {
          dialyzerEnabled = false,
          fetchDeps = false
        }
      }
    }
    opts = vim.tbl_deep_extend("force", elixirls_opts, opts)
  end

  server:setup(opts)
end)
