-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- enter command mode by pressing ;
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Press jk fast to exit insert mode
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)

-- Copy whole file
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- save file without auto-formatting
map("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- delete single character without copying into register
map("n", "x", '"_x', opts)

-- Buffers
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<C-i>", "<C-i>", opts) -- to restore jump forward

-- Keep last yanked when pasting
map("v", "p", '"_dP', opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
