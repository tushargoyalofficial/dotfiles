-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin", -- default theme
  theme_toggle = { "catppuccin", "gruvbox_light" },
  transparency = true,

	nvdash = {
    load_on_startup = true,
  },

	cmp = {
    style = "atom",
  },

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

return M
