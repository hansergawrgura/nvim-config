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
