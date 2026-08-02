-- lua/util/init.lua
-- Shared helper functions.

local M = {}

---Create an augroup and return its id.
---@param name string
---@param clear? boolean default true
---@return integer
function M.augroup(name, clear)
  return vim.api.nvim_create_augroup(name, { clear = clear == nil and true or clear })
end

---Map a key with optional desc and opts merged in.
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc? string
---@param opts? table
function M.map(mode, lhs, rhs, desc, opts)
  local o = vim.tbl_deep_extend("force", { desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, o)
end

---Check if a command is executable.
---@param cmd string
---@return boolean
function M.has(cmd)
  return vim.fn.executable(cmd) == 1
end

return M
