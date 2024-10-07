-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin", -- default theme
  theme_toggle = { "catppuccin", "gruvbox_light" },
  transparency = true,
}

M.ui = {
  cmp = {
    style = "atom_colored",
  },
}

M.nvdash = {
  load_on_startup = true,
}

return M
