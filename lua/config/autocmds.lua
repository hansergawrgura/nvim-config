-- lua/config/autocmds.lua
-- Autocommands. Use named augroups for clean management.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- vim.hl on nvim >= 0.11, vim.highlight on older (compat)
local hl = vim.hl or vim.highlight

-- Highlight yanked text
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    hl.on_yank()
  end,
  desc = "Highlight yanked text",
})

-- Restore cursor position on file reopen
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 1 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = "Restore cursor position on reopen",
})

-- Filetype-based comment prefixes for header insertion
local comment_prefixes = {
  python = "#", ruby = "#", sh = "#", bash = "#", zsh = "#", yaml = "#",
  toml = "#", perl = "#", r = "#", dockerfile = "#", makefile = "#", conf = "#",
  c = "//", cpp = "//", java = "//", javascript = "//", typescript = "//",
  go = "//", rust = "//", swift = "//", kotlin = "//", scala = "//", dart = "//",
  csharp = "//", objc = "//", php = "//",
  lua = "--", haskell = "--", sql = "--",
  css = "/*", scss = "/*", less = "/*",
  html = "<!--", xml = "<!--", markdown = "<!--",
}

autocmd("BufNewFile", {
  group = augroup("FileHeader", { clear = true }),
  callback = function()
    local prefix = comment_prefixes[vim.bo.filetype]
    if not prefix then return end

    local author = vim.fn.system("git config user.name"):gsub("%s+$", "")
    if author == "" then author = "Unknown" end
    local date = os.date("%Y-%m-%d")
    local filename = vim.fn.expand("%:t")

    local lines
    if prefix == "/*" then
      lines = {
        "/*",
        " * Author: " .. author,
        " * Date: " .. date,
        " * File: " .. filename,
        " * Description: ",
        " */",
        "",
      }
    elseif prefix == "<!--" then
      lines = {
        "<!--",
        "  Author: " .. author,
        "  Date: " .. date,
        "  File: " .. filename,
        "  Description: ",
        "-->",
        "",
      }
    else
      lines = {
        prefix .. " Author: " .. author,
        prefix .. " Date: " .. date,
        prefix .. " File: " .. filename,
        prefix .. " Description: ",
        "",
      }
    end

    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    local desc_line = #lines - 1
    vim.api.nvim_win_set_cursor(0, { desc_line, #lines[desc_line] })
  end,
  desc = "Insert file header on new file creation",
})
