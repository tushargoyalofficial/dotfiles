require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape from command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
