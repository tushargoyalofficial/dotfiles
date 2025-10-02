-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape from command mode" })

map({ "i", "n", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>de", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end, { desc = "Show line diagnostics" })
