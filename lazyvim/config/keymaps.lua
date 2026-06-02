-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Enter command mode by pressing ;
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Press jk fast to exit insert mode
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)

-- Copy whole file to system clipboard
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Save file without triggering auto-formatting (LSP/Conform)
map("n", "<leader>sn", "<cmd>noautocmd w <CR>", { desc = "Save without formatting", noremap = true, silent = true })

-- Delete single character without copying it into the clipboard register
map("n", "x", '"_x', opts)

-- Keep last yanked when pasting in Visual Mode (uses modern native engine)
map("x", "p", "P", opts)

-- Move highlighted text blocks up and down (VS Code style - keeps selection active)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Optional: If you strictly prefer Tab over LazyVim's default H/L for buffers:
-- map("n", "<Tab>", "<cmd>bnext<CR>", opts)
-- map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts)
