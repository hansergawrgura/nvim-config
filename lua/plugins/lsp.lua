-- lua/plugins/lsp.lua
-- mason.nvim + nvim-lspconfig using vim.lsp.config / vim.lsp.enable (nvim 0.11+ API).

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
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.enable(servers)

      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        float = { border = "rounded", source = "if_many" },
        severity_sort = true,
      })
    end,
  },
}
