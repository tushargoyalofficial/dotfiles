require "nvchad.options"

-- add yours here!
local opt = vim.opt
opt.title = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.cursorlineopt = "both"

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

