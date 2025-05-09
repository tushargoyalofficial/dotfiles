require "nvchad.options"

local o = vim.o
o.title = true
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.cursorlineopt = "both"
