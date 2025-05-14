require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape from command mode" })

map({ "i", "n", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    winopts = { winhl = "Normal:floatTermBg,FloatBorder:floatTermBorder" },
  }
end, { desc = "terminal toggle floating term" })

map("n", "<leader>whi", "<C-w>+", { desc = "Increase window height" })
map("n", "<leader>whd", "<C-w>-", { desc = "Decrease window height" })
map("n", "<leader>wwi", "<C-w>>", { desc = "Increase window width" })
map("n", "<leader>wwd", "<C-w><", { desc = "Decrease window width" })

map("n", "<leader>de", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end, { desc = "Show line diagnostics" })

map({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()
  -- vim.cmd.exec '"normal! G"'

  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)

  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

map("n", "<up>", function()
  require("minty.utils").lighten_on_cursor(3)
end)

map("n", "<down>", function()
  require("minty.utils").lighten_on_cursor(-3)
end)
