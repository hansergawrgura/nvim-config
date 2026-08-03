-- lua/config/keymaps.lua
-- Key mappings. Leader is space.

local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save and quit
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write and quit" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })
map("n", "<leader>wa", "<cmd>wall<CR>", { desc = "Save all files" })

-- Buffer management
map("n", "<leader>bb", "<cmd>buffer #<CR>", { desc = "Switch to alternate buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window layout
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Keep only current tab" })
map("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Diagnostics and LSP
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<leader>lr", vim.lsp.buf.references, { desc = "List references" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer with LSP" })

-- Utilities
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" })
map("n", "<leader>a", "ggVG", { desc = "Select all text" })
map("n", "<leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy file path" })
map("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Open Mason" })
map("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

-- Move selected lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
