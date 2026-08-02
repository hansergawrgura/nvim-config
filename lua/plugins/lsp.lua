-- lua/plugins/lsp.lua
-- mason.nvim + nvim-lspconfig: install and configure LSP servers for all mainstream stacks.

local servers = {
  "pyright",       -- Python
  "jdtls",         -- Java
  "clangd",        -- C / C++
  "ts_ls",         -- TypeScript / JavaScript
  "html",          -- HTML
  "cssls",         -- CSS
  "gopls",         -- Go
  "rust_analyzer", -- Rust
  "lua_ls",        -- Lua
  "bashls",        -- Bash
  "jsonls",        -- JSON
  "yamlls",        -- YAML
  "marksman",      -- Markdown
}

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = servers,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "Saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- Diagnostic signs and display
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        float = { border = "rounded", source = "if_many" },
        severity_sort = true,
      })
    end,
  },
}
