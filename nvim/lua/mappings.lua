require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape from command mode" })
map("n", "<Bslash>", function()
  require("shade").toggle()
end, { desc = "Toggle shade.nvim" })

map({ "i", "n", "v" }, "<C-s>", "<cmd> w <cr>")
