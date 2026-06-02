-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- [ SPEED & UI ]
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (300ms is the sweet spot)
vim.opt.updatetime = 200 -- Faster completion & faster diagnostic hover (default is 4000ms!)
vim.opt.cursorline = true -- Highlight the text line where the cursor is (makes finding yourself instant)

-- [ THE NAVIGATION "PRO" COMBO ]
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Hybrid numbers: Current line = absolute, others = distance.
-- This is your "Sniper Mode" for vertical jumps.

-- [ SCROLLING & SIGHT ] vim.opt.scrolloff = 10 -- Always keep 10 lines above/below cursor (You see context before you arrive)
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes" -- Always show signs (Gutter for git/LSP) to prevent "layout jumping"

-- [ SEARCHING ]
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- If search has a Capital Letter, it becomes case-sensitive
vim.opt.hlsearch = true -- Highlight all matches

-- [ SPLITS ]
vim.opt.splitright = true -- Put new windows to the right
vim.opt.splitbelow = true -- Put new windows below

-- [ MISC PRODUCTIVITY ]
vim.opt.wrap = false -- Don't wrap long lines (easier to read code structure)
vim.opt.undofile = true -- Persistent undo: Neovim remembers undos even after closing the file!
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.mouse = "a" -- Mouse support is actually 'pro' when scrolling long logs/output

-- [ HIDDEN GEMS ]
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.laststatus = 3 -- Global statusline (looks much cleaner than one per split)
