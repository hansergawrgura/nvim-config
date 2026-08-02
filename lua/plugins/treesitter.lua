return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "python", "java", "c", "cpp", "typescript", "tsx",
        "javascript", "html", "css", "go", "rust", "lua",
        "bash", "json", "yaml", "markdown", "markdown_inline",
        "vim", "vimdoc", "regex", "sql", "toml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
